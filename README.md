FINANZAS PERSONALES

¿A dónde se va tu plata? Esta app te lo muestra. Registra cada gasto por categoría, medio de pago y fecha, y míralo en un panel interactivo con gráficos, filtros y metas mensuales. Construida con Oracle (modelo estrella) y Streamlit, convierte tus compras diarias en decisiones para organizar mejor tu dinero.


FUNCIONALIDADES

Resumen: total gastado, número de gastos, promedio, gasto más alto y categoría líder, con comparación frente al mes anterior y progreso hacia una meta mensual.
Gráficos: gasto por categoría, por medio de pago, por mes y evolución diaria.

Movimientos: búsqueda por descripción, descarga en CSV, edición y eliminación de gastos.

Registro de gastos: si la fecha no existe en la base de datos, la app la crea automáticamente.

Catálogos: consulta y creación de categorías y medios de pago sin duplicados.

Filtros dinámicos: por año, mes, categoría y medio de pago.


MODELO DE DATOS

Modelo estrella con una tabla de hechos y tres dimensiones:

<img width="801" height="392" alt="Modelo estrella" src="https://github.com/user-attachments/assets/ae3f7f9b-8c8d-4396-85a8-db07089ec7f4" />

REGLAS PRINCIPALES

Todo gasto pertenece a una categoría, un medio de pago y una fecha existentes; el valor debe ser mayor a 0; los nombres de categorías y medios de pago son únicos; cada fecha se registra una sola vez en la dimensión y puede asociarse a muchos gastos.


TECNOLOGÍAS

Python 
Streamlit: interfaz web

python-oracledb: conexión a Oracle

pandas y Altair: manejo de datos y gráficos

Oracle Database



CONTENIDO DEL REPOSITORIO

FP.py --> Aplicación Streamlit

DDL_finanzas_personales.sql --> Creación de las tablas 

DML_finanzas_personales.sql --> Datos de ejemplo




AUTORAS

Dana Tzelem Cantillo Parra y Sofía Calle
