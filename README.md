# Finanzas personales

¿A dónde se va tu plata? Esta app te lo muestra. Registra cada gasto por categoría, medio de pago y fecha, y míralo en un panel interactivo con gráficos, filtros y metas mensuales. Construida con Oracle (modelo estrella) y Streamlit, convierte tus compras diarias en decisiones para organizar mejor tu dinero.

## Funcionalidades

- **Resumen:** total gastado, promedio, gasto más alto y categoría líder, con comparación frente al mes anterior y progreso hacia una meta mensual.
- **Gráficos:** gasto por categoría, por medio de pago, por mes y evolución diaria.
- **Movimientos:** búsqueda por descripción, descarga en CSV, edición y eliminación de gastos.
- **Registro de gastos:** si la fecha no existe en la base de datos, la app la crea automáticamente.
- **Catálogos:** consulta y creación de categorías y medios de pago sin duplicados.
- **Filtros dinámicos:** por año, mes, categoría y medio de pago.

## Modelo de datos

Modelo estrella con una tabla de hechos (`HECHO_GASTO`) y tres dimensiones (`DIM_CATEGORIA`, `DIM_MEDIO_PAGO` y `DIM_FECHA_COMPRA`).

<img width="801" height="392" alt="Modelo estrella" src="https://github.com/user-attachments/assets/0e3d5e04-008a-4932-acf0-a28c5aab9bad" />

## Contenido del repositorio

| Archivo | Descripción |
|---|---|
| `FP.py` | Aplicación Streamlit |
| `DDL_fp.sql` | Creación de las tablas |
| `DML_fp.sql` | Datos de ejemplo (60 gastos) |
| `Diseño de la base de datos (2).pdf` | Documento de diseño |
| `Condiciones de negocio.pdf` | Reglas de negocio |
| `Modelo estrella.jpeg` | Diagrama del modelo estrella |

### Librerías necesarias
 
Requiere Python 3 y estas librerías:
 
| Librería | Para qué se usa |
|---|---|
| `streamlit` | Interfaz web |
| `oracledb` | Conexión a Oracle |
| `pandas` | Manejo de datos |
| `altair` | Gráficos |

### Orden de los scripts SQL
 
Ejecuta los scripts en tu base de datos Oracle **en este orden** (en SQL Developer, con *Run Script* o `F5`):
 
1. **`DDL_fp.sql`**: crea las tres dimensiones y, al final, la tabla de hechos. Este orden es obligatorio porque `HECHO_GASTO` tiene llaves foráneas hacia las dimensiones.
2. **`DML_fp.sql`**: carga los datos de ejemplo (8 categorías, 4 medios de pago, 30 fechas y 60 gastos).
**1. DDL: creación de las tablas**
 
**2. DML: inserción de datos**
 
Para comprobar la carga, estas consultas deben devolver 8, 4, 30 y 60:
 
```sql
SELECT COUNT(*) FROM dim_categoria;
SELECT COUNT(*) FROM dim_medio_pago;
SELECT COUNT(*) FROM dim_fecha_compra;
SELECT COUNT(*) FROM hecho_gasto;
```

## App

<img width="1365" height="630" alt="image" src="https://github.com/user-attachments/assets/4336f9c9-fc2b-48eb-af49-ec0f2bf4e8e2" />
<img width="1350" height="638" alt="image" src="https://github.com/user-attachments/assets/5fe48f61-511d-4a95-982d-aee5f6c008f2" />
<img width="1365" height="651" alt="image" src="https://github.com/user-attachments/assets/cf90e97f-2af7-4cd3-8d95-14ac16384dc5" />
<img width="1365" height="632" alt="image" src="https://github.com/user-attachments/assets/8f931185-cd86-41f8-a724-43387537342f" />
<img width="1364" height="636" alt="image" src="https://github.com/user-attachments/assets/14169cdb-8b94-427b-8b9d-809440da672a" />
<img width="1365" height="635" alt="image" src="https://github.com/user-attachments/assets/2a4497bc-aadc-49be-9a69-3c97f3761fd2" />


## Autoras

Dana Tzelem Cantillo Parra y Sofía Calle

Proyecto académico de bases de datos, Universidad EAFIT.
