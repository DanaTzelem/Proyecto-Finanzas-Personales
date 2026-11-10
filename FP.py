import datetime as dt
from contextlib import contextmanager

import altair as alt
import oracledb
import pandas as pd
import streamlit as st

MAX_FILAS = 1000
MESES = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto",
         "Septiembre", "Octubre", "Noviembre", "Diciembre"]
TINTA, VERDE, AMBAR = "#12343B", "#1F8A70", "#E9A23B"
PALETA = [VERDE, TINTA, AMBAR, "#5B8DB8", "#C8553D", "#8A9BA3", "#7A5C99", "#3FB68B"]

# ================================================================
# 1. CONEXIÓN A ORACLE
# ================================================================
@st.cache_resource
def get_pool():
    """Crea un pool de conexiones que se reutilizan (conectar es lento)."""
    c = st.secrets["oracle"]
    config_dir = c.get("config_dir")
    extra = {}
    if c.get("lib_dir"):      # WINDOWS -> modo thick con Instant Client
        oracledb.init_oracle_client(lib_dir=c["lib_dir"], config_dir=config_dir)
    else:                     # MAC -> modo thin con wallet
        extra = dict(config_dir=config_dir, wallet_location=c.get("wallet_location", config_dir),
                     wallet_password=c.get("wallet_password"))
    return oracledb.create_pool(user=c["user"], password=c["password"], dsn=c["dsn"], min=1, max=4, **extra)


def conexion():
    con = get_pool().acquire()
    esquema = st.secrets["oracle"].get("schema")
    if esquema and esquema.isidentifier():
        con.cursor().execute(f"ALTER SESSION SET CURRENT_SCHEMA = {esquema}")
    return con


def consultar(sql, **params):
    """Ejecuta UN SELECT con parámetros con nombre (:anio, :mes...) y devuelve un DataFrame."""
    con = conexion()
    try:
        cur = con.cursor()
        cur.execute(sql, params)
        columnas = [d[0].lower() for d in cur.description]
        return pd.DataFrame(cur.fetchmany(MAX_FILAS), columns=columnas)
    finally:
        con.close()


class Tx:
    """Ayudante para ejecutar SQL de escritura dentro de una transacción."""

    def __init__(self, con):
        self.con = con

    def run(self, sql, **params):
        cur = self.con.cursor()
        cur.execute(sql, params)
        return cur.rowcount

    def primero(self, sql, **params):
        """Devuelve el primer valor de la primera fila (o None si no hay filas)."""
        cur = self.con.cursor()
        cur.execute(sql, params)
        fila = cur.fetchone()
        return fila[0] if fila else None

    def insert(self, sql, id_col, **params):
        """INSERT que devuelve el ID generado por la columna IDENTITY."""
        cur = self.con.cursor()
        nuevo = cur.var(int)
        cur.execute(f"{sql} RETURNING {id_col} INTO :new_id", {**params, "new_id": nuevo})
        return int(nuevo.getvalue()[0])


@contextmanager
def transaccion():
    """Todo lo del 'with' se guarda junto (COMMIT) o no se guarda nada (ROLLBACK)."""
    con = conexion()
    try:
        yield Tx(con)
        con.commit()
    except Exception:
        con.rollback()
        raise
    finally:
        con.close()


# ================================================================
# 2. PÁGINA, ESTILO Y FUNCIONES DE APOYO
# ================================================================
st.set_page_config(page_title="Finanzas personales", page_icon="💰", layout="wide")
st.markdown(
    f"""
    <style>
    .banner {{background:{TINTA}; color:#fff; padding:1.1rem 1.6rem; border-radius:12px;
              border-bottom:4px solid {AMBAR}; margin-bottom:1rem;}}
    .banner h1 {{margin:0; font-size:1.9rem; color:#fff;}}
    .banner p {{margin:0; opacity:.85;}}
    div[data-testid="stMetric"] {{background:#fff; border:1px solid #DDE5E3; border-left:5px solid {VERDE};
                                 padding:.7rem 1rem; border-radius:8px;}}
    div[data-testid="stMetricLabel"], div[data-testid="stMetricValue"] {{color:{TINTA};}}
    </style>
    <div class="banner"><h1>💰 Finanzas personales</h1>
    <p>Registra tus gastos, mira en qué se va tu plata y cumple tu meta del mes</p></div>
    """,
    unsafe_allow_html=True,
)


def cop(v):
    """Formato de pesos colombianos: $ 1.250.000"""
    return "$ " + f"{float(v):,.0f}".replace(",", ".")


def fechas(df):
    for c in df.columns:
        if c.startswith("fecha"):
            df[c] = pd.to_datetime(df[c]).dt.date
    return df


def flash(msg):
    """Mensaje que sobrevive al st.rerun()."""
    st.session_state["flash"] = msg
    st.rerun()


def barras(df, cat, val, horizontal=False):
    """Gráfico de barras; sort=None respeta el orden en que Oracle devolvió las filas."""
    if horizontal:
        ejes = dict(x=alt.X(f"{val}:Q", title=None), y=alt.Y(f"{cat}:N", sort=None, title=None))
    else:
        ejes = dict(x=alt.X(f"{cat}:N", sort=None, title=None, axis=alt.Axis(labelAngle=0)),
                    y=alt.Y(f"{val}:Q", title=None))
    return (alt.Chart(df).mark_bar(color=VERDE, cornerRadiusEnd=4)
            .encode(**ejes, tooltip=[cat, alt.Tooltip(val, format=",.0f")]).properties(height=280))


if "flash" in st.session_state:
    st.success(st.session_state.pop("flash"))

try:
    consultar("SELECT COUNT(*) AS n FROM dim_categoria")
except Exception as e:
    st.error(f"No se pudo conectar a la base de datos: {e}")
    st.info("Revisa .streamlit/secrets.toml y que hayas ejecutado el DDL y el DML en esta base de datos.")
    st.stop()

# Catálogos pequeños (dimensiones) que usan los filtros y los formularios
SQL_CATS = "SELECT ca_id_categorias AS id, ca_nombre_categorias AS nombre FROM dim_categoria ORDER BY ca_nombre_categorias"
SQL_MEDIOS = "SELECT mp_id_medio_pago AS id, mp_nombre_medio_pago AS nombre FROM dim_medio_pago ORDER BY mp_nombre_medio_pago"
cats, medios = consultar(SQL_CATS), consultar(SQL_MEDIOS)
ids_cat, ids_med = cats.id.astype(int).tolist(), medios.id.astype(int).tolist()
nom_cat, nom_med = dict(zip(ids_cat, cats.nombre)), dict(zip(ids_med, medios.nombre))

# ---------------- Filtros (barra lateral): afectan Resumen y Movimientos ----------------
st.sidebar.header("🔎 Filtros")
anios = consultar("SELECT DISTINCT anio FROM dim_fecha_compra ORDER BY anio DESC").anio.astype(int).tolist()
ANIO = st.sidebar.selectbox("Año", anios or [dt.date.today().year])
MES = st.sidebar.selectbox("Mes", list(range(13)), format_func=lambda m: "Todo el año" if m == 0 else MESES[m - 1])
CAT = st.sidebar.selectbox("Categoría", [0] + ids_cat, format_func=lambda x: "Todas" if x == 0 else nom_cat[x])
MED = st.sidebar.selectbox("Medio de pago", [0] + ids_med, format_func=lambda x: "Todos" if x == 0 else nom_med[x])
META = st.sidebar.number_input("Meta mensual de gasto (COP)", min_value=0, value=1_500_000, step=100_000)

# 0 significa "sin filtro": (:mes = 0 OR f.mes = :mes) deja pasar todo cuando el filtro es 0.
F = dict(anio=int(ANIO), mes=int(MES), cat=int(CAT), med=int(MED))
F_ANIO = {k: v for k, v in F.items() if k != "mes"}      # para la gráfica de todos los meses

JOINS = """
    FROM hecho_gasto g
    JOIN dim_fecha_compra f ON f.fc_id_fecha_compra = g.fc_id_fecha_compra
    JOIN dim_categoria c    ON c.ca_id_categorias   = g.ca_id_categorias
    JOIN dim_medio_pago m   ON m.mp_id_medio_pago   = g.mp_id_medio_pago"""
WHERE_ANIO = """
    WHERE f.anio = :anio
      AND (:cat = 0 OR g.ca_id_categorias = :cat)
      AND (:med = 0 OR g.mp_id_medio_pago = :med)"""
BASE_ANIO = JOINS + WHERE_ANIO
BASE = BASE_ANIO + " AND (:mes = 0 OR f.mes = :mes)"

t_res, t_mov, t_nuevo, t_cat = st.tabs(["📊 Resumen", "🧾 Movimientos", "➕ Registrar gasto", "🏷️ Categorías y medios"])


# ================================================================
# 3. RESUMEN  ·  solo LEE  ·  Oracle suma y agrupa
# ================================================================
with t_res:
    SQL_KPIS = ("SELECT NVL(SUM(g.valor),0) AS total, COUNT(*) AS n, NVL(AVG(g.valor),0) AS promedio, "
                "NVL(MAX(g.valor),0) AS maximo " + BASE)
    SQL_TOTAL = "SELECT NVL(SUM(g.valor),0) AS total " + BASE
    SQL_POR_CAT = ("SELECT c.ca_nombre_categorias AS categoria, SUM(g.valor) AS total, COUNT(*) AS gastos " + BASE +
                   " GROUP BY c.ca_nombre_categorias ORDER BY total DESC")
    SQL_POR_MEDIO = ("SELECT m.mp_nombre_medio_pago AS medio, SUM(g.valor) AS total " + BASE +
                     " GROUP BY m.mp_nombre_medio_pago ORDER BY total DESC")
    SQL_POR_MES = ("SELECT f.mes AS mes, SUM(g.valor) AS total " + BASE_ANIO + " GROUP BY f.mes ORDER BY f.mes")
    SQL_POR_DIA = ("SELECT f.fecha AS fecha, SUM(g.valor) AS total " + BASE + " GROUP BY f.fecha ORDER BY f.fecha")
    SQL_TOP = ("SELECT f.fecha AS fecha, c.ca_nombre_categorias AS categoria, m.mp_nombre_medio_pago AS medio, "
               "g.descripcion AS descripcion, g.valor AS valor " + BASE + " ORDER BY g.valor DESC")

    k = consultar(SQL_KPIS, **F).iloc[0]
    total, n = float(k["total"]), int(k["n"])

    if n == 0:
        st.info("No hay gastos con estos filtros. Cambia los filtros o registra un gasto en la pestaña «Registrar gasto».")
    else:
        por_cat, por_med = consultar(SQL_POR_CAT, **F), consultar(SQL_POR_MEDIO, **F)

        # Comparación con el mes anterior (solo cuando hay un mes elegido)
        delta = None
        if MES:
            pa, pm = (ANIO - 1, 12) if MES == 1 else (ANIO, MES - 1)
            previo = float(consultar(SQL_TOTAL, **{**F, "anio": pa, "mes": pm}).iloc[0, 0])
            if previo:
                delta = f"{100 * (total - previo) / previo:+.0f}% vs mes anterior"

        c = st.columns(5)
        c[0].metric("Total gastado", cop(total), delta, delta_color="inverse")
        c[1].metric("Número de gastos", n)
        c[2].metric("Gasto promedio", cop(k["promedio"]))
        c[3].metric("Gasto más alto", cop(k["maximo"]))
        c[4].metric("Categoría líder", por_cat.categoria.iloc[0])

        if MES and META:
            pct = total / META
            st.progress(min(pct, 1.0), text=f"{pct:.0%} de tu meta de {MESES[MES - 1]} ({cop(META)})")
            if pct > 1:
                st.warning(f"Superaste tu meta por {cop(total - META)}.")

        lider, medio = por_cat.iloc[0], por_med.iloc[0]
        st.info(f"💡 **{lider.categoria}** concentra el {100 * float(lider.total) / total:.0f}% de tu gasto "
                f"y pagas sobre todo con **{medio.medio}** ({100 * float(medio.total) / total:.0f}%).")

        g1, g2 = st.columns([3, 2])
        with g1:
            st.subheader("Gasto por categoría")
            st.altair_chart(barras(por_cat, "categoria", "total", horizontal=True), width="stretch")
        with g2:
            st.subheader("Medios de pago")
            dona = (alt.Chart(por_med).mark_arc(innerRadius=60)
                    .encode(theta="total:Q", color=alt.Color("medio:N", scale=alt.Scale(range=PALETA),
                                                             legend=alt.Legend(title=None, orient="bottom")),
                            tooltip=["medio", alt.Tooltip("total", format=",.0f")]).properties(height=280))
            st.altair_chart(dona, width="stretch")

        g3, g4 = st.columns(2)
        with g3:
            st.subheader(f"Gasto por mes ({ANIO})")
            por_mes = consultar(SQL_POR_MES, **F_ANIO)
            por_mes["mes"] = por_mes.mes.astype(int).map(lambda m: MESES[m - 1][:3])
            st.altair_chart(barras(por_mes, "mes", "total"), width="stretch")
        with g4:
            st.subheader("Evolución diaria")
            por_dia = consultar(SQL_POR_DIA, **F)
            por_dia["fecha"] = pd.to_datetime(por_dia["fecha"])
            area = (alt.Chart(por_dia).mark_area(opacity=.25, color=VERDE, line={"color": VERDE})
                    .encode(x=alt.X("fecha:T", title=None), y=alt.Y("total:Q", title=None),
                            tooltip=[alt.Tooltip("fecha:T", format="%d/%m/%Y"), alt.Tooltip("total", format=",.0f")])
                    .properties(height=280))
            st.altair_chart(area, width="stretch")

        st.subheader("Los 5 gastos más altos")
        st.dataframe(fechas(consultar(SQL_TOP, **F)).head(5), hide_index=True, width="stretch",
                     column_config={"valor": st.column_config.NumberColumn("Valor", format="$ %d")})


# ================================================================
# 4. MOVIMIENTOS  ·  LEE (búsqueda con LIKE)  ·  ESCRIBE (editar y eliminar)
# ================================================================
with t_mov:
    SQL_MOV = ("SELECT g.hg_id_gasto AS id, g.ca_id_categorias AS cat_id, g.mp_id_medio_pago AS med_id, "
               "f.fecha AS fecha, c.ca_nombre_categorias AS categoria, m.mp_nombre_medio_pago AS medio, "
               "g.descripcion AS descripcion, g.valor AS valor " + BASE +
               " AND UPPER(NVL(g.descripcion, ' ')) LIKE UPPER(:q) ORDER BY f.fecha DESC, g.hg_id_gasto DESC")
    busca = st.text_input("🔎 Buscar en la descripción", placeholder="Ej: almuerzo, taxi, mercado...")
    mov = fechas(consultar(SQL_MOV, q=f"%{busca}%", **F))
    st.caption(f"{len(mov)} movimientos · total {cop(mov.valor.sum())} (máximo {MAX_FILAS} filas)")
    st.dataframe(mov.drop(columns=["id", "cat_id", "med_id"]), hide_index=True, width="stretch",
                 column_config={"valor": st.column_config.NumberColumn("Valor", format="$ %d"),
                                "fecha": st.column_config.DateColumn("Fecha", format="DD/MM/YYYY")})
    st.download_button("⬇️ Descargar CSV", mov.drop(columns=["id", "cat_id", "med_id"]).to_csv(index=False).encode("utf-8-sig"),
                       "gastos.csv", "text/csv", disabled=mov.empty)

    with st.expander("✏️ Editar o eliminar un gasto"):
        if mov.empty:
            st.caption("No hay movimientos con estos filtros.")
        else:
            etiq = {int(r.id): f"#{r.id} · {r.fecha} · {r.descripcion or r.categoria} · {cop(r.valor)}" for r in mov.itertuples()}
            gid = st.selectbox("Gasto", list(etiq), format_func=etiq.get)
            fila = mov[mov.id == gid].iloc[0]
            with st.form("editar"):
                e1, e2 = st.columns(2)
                ecat = e1.selectbox("Categoría", ids_cat, index=ids_cat.index(int(fila.cat_id)),
                                    format_func=nom_cat.get, key=f"ecat{gid}")
                emed = e2.selectbox("Medio de pago", ids_med, index=ids_med.index(int(fila.med_id)),
                                    format_func=nom_med.get, key=f"emed{gid}")
                evalor = e1.number_input("Valor (COP)", min_value=0, value=int(fila.valor), step=1000, key=f"eval{gid}")
                edesc = e2.text_input("Descripción", value=fila.descripcion or "", max_chars=100, key=f"edesc{gid}")
                guardar = st.form_submit_button("Guardar cambios", type="primary")
            if guardar:
                if evalor <= 0:
                    st.warning("El valor debe ser mayor a 0.")
                else:
                    SQL_UPDATE = """UPDATE hecho_gasto
                                    SET ca_id_categorias = :cat, mp_id_medio_pago = :med, descripcion = :descr, valor = :valor
                                    WHERE hg_id_gasto = :cod"""
                    with transaccion() as t:
                        t.run(SQL_UPDATE, cat=int(ecat), med=int(emed), descr=edesc.strip() or None,
                              valor=int(evalor), cod=int(gid))
                    flash(f"Gasto #{gid} actualizado.")

            seguro = st.checkbox("Confirmo que quiero eliminar este gasto", key=f"conf{gid}")
            if st.button("🗑️ Eliminar gasto", disabled=not seguro):
                with transaccion() as t:
                    t.run("DELETE FROM hecho_gasto WHERE hg_id_gasto = :cod", cod=int(gid))
                flash(f"Gasto #{gid} eliminado.")


# ================================================================
# 5. REGISTRAR GASTO  ·  ESCRIBE en dim_fecha_compra (si hace falta) y hecho_gasto
# ================================================================
with t_nuevo:
    st.subheader("Registrar un gasto")
    if not ids_cat or not ids_med:
        st.warning("Primero crea al menos una categoría y un medio de pago en la pestaña «Categorías y medios».")
    else:
        with st.form("nuevo_gasto", clear_on_submit=True):
            n1, n2 = st.columns(2)
            fecha = n1.date_input("Fecha", value=dt.date.today(), max_value=dt.date.today())
            valor = n2.number_input("Valor (COP)", min_value=0, value=0, step=1000)
            cat = n1.selectbox("Categoría", ids_cat, format_func=nom_cat.get)
            med = n2.selectbox("Medio de pago", ids_med, format_func=nom_med.get)
            descr = st.text_input("Descripción (opcional)", max_chars=100)
            if st.form_submit_button("Guardar gasto", type="primary"):
                if valor <= 0:
                    st.warning("El valor debe ser mayor a 0.")
                else:
                    SQL_BUSCAR_FECHA = "SELECT fc_id_fecha_compra FROM dim_fecha_compra WHERE fecha = :f"
                    SQL_NUEVA_FECHA = "INSERT INTO dim_fecha_compra (fecha, mes, anio) VALUES (:f, :mes, :anio)"
                    SQL_NUEVO_GASTO = """INSERT INTO hecho_gasto (ca_id_categorias, mp_id_medio_pago, fc_id_fecha_compra, descripcion, valor)
                                         VALUES (:cat, :med, :fc, :descr, :valor)"""
                    with transaccion() as t:
                        # Si la fecha aún no existe en la dimensión, se crea; luego se inserta el gasto.
                        fc = t.primero(SQL_BUSCAR_FECHA, f=fecha)
                        if fc is None:
                            fc = t.insert(SQL_NUEVA_FECHA, "fc_id_fecha_compra", f=fecha, mes=fecha.month, anio=fecha.year)
                        t.run(SQL_NUEVO_GASTO, cat=int(cat), med=int(med), fc=int(fc),
                              descr=descr.strip() or None, valor=int(valor))
                    flash(f"Gasto de {cop(valor)} registrado en {nom_cat[cat]}.")


# ================================================================
# 6. CATEGORÍAS Y MEDIOS DE PAGO  ·  LEE (LEFT JOIN + COUNT)  ·  ESCRIBE (INSERT en dimensiones)
# ================================================================
def catalogo(titulo, sql_stats, tabla, columna, existentes, max_len, key):
    """Muestra cuánto se usa cada elemento y permite agregar uno nuevo (tabla/columna son constantes del código)."""
    st.subheader(titulo)
    st.dataframe(consultar(sql_stats), hide_index=True, width="stretch",
                 column_config={"total": st.column_config.NumberColumn("Total", format="$ %d")})
    with st.form(key, clear_on_submit=True):
        nuevo = st.text_input("Nombre nuevo", max_chars=max_len)
        if st.form_submit_button("Agregar"):
            nuevo = nuevo.strip()
            if not nuevo:
                st.warning("Escribe un nombre.")
            elif nuevo.casefold() in [x.casefold() for x in existentes]:
                st.warning(f"«{nuevo}» ya existe.")
            else:
                with transaccion() as t:
                    t.run(f"INSERT INTO {tabla} ({columna}) VALUES (:n)", n=nuevo)
                flash(f"«{nuevo}» agregado.")


with t_cat:
    # LEFT JOIN: aparecen también los elementos que todavía no tienen gastos (COUNT = 0).
    SQL_STATS_CAT = """
        SELECT c.ca_nombre_categorias AS categoria, COUNT(g.hg_id_gasto) AS gastos, NVL(SUM(g.valor), 0) AS total
        FROM dim_categoria c
        LEFT JOIN hecho_gasto g ON g.ca_id_categorias = c.ca_id_categorias
        GROUP BY c.ca_nombre_categorias
        ORDER BY total DESC"""
    SQL_STATS_MED = """
        SELECT m.mp_nombre_medio_pago AS medio_de_pago, COUNT(g.hg_id_gasto) AS gastos, NVL(SUM(g.valor), 0) AS total
        FROM dim_medio_pago m
        LEFT JOIN hecho_gasto g ON g.mp_id_medio_pago = m.mp_id_medio_pago
        GROUP BY m.mp_nombre_medio_pago
        ORDER BY total DESC"""
    x1, x2 = st.columns(2)
    with x1:
        catalogo("Categorías", SQL_STATS_CAT, "dim_categoria", "ca_nombre_categorias", cats.nombre.tolist(), 50, "form_cat")
    with x2:
        catalogo("Medios de pago", SQL_STATS_MED, "dim_medio_pago", "mp_nombre_medio_pago", medios.nombre.tolist(), 30, "form_med")