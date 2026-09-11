# Proyecto Ventas -  SQL

Proyecto de base de datos para un comercio retail, desarrollado en PostgreSQL.

## Contenido

El archivo `ventas_project.sql`:

- Crea la base de datos `ventas_project`.
- Crea las tablas `clientes`, `productos` y `ventas`.
- Define claves primarias, claves foráneas, restricciones `UNIQUE`, `NOT NULL` y `CHECK`.
- Inserta al menos cinco registros por tabla dentro de una transacción.
- Actualiza precios de productos de Tecnología.
- Elimina una venta de prueba usando `WHERE`.

## Pre-entrega Módulo 4: Consultas multicapa para análisis de negocio

Este repositorio contiene consultas SQL desarrolladas en PostgreSQL para analizar información de un proyecto retail.

## Archivo principal

- `pre-entrega-modulo4.sql`: contiene las tres consultas solicitadas para la pre-entrega.

## Estructura de la base de datos

La base de datos `retail_project` utiliza las siguientes tablas:

- `clientes`
- `productos`
- `categorias`
- `ventas`

Relaciones principales:

- `ventas.cliente_id` referencia a `clientes.cliente_id`.
- `ventas.producto_id` referencia a `productos.producto_id`.
- `productos.categoria_id` referencia a `categorias.categoria_id`.

## Consultas incluidas

1. **Rentabilidad por categoría:** muestra unidades vendidas e ingresos totales por categoría, filtrando categorías que superan un umbral de ventas.
2. **Clientes sin compras:** identifica clientes registrados que no tienen ventas asociadas.
3. **Top de compras por cliente:** muestra el producto más comprado por cada cliente y la fecha de su última transacción.

## Requisitos

- PostgreSQL.
- Base de datos `retail_project` creada y con datos cargados.
- Herramienta de administración como DBeaver o pgAdmin.

## Ejecución

1. Abrir DBeaver o pgAdmin.
2. Conectarse a la base de datos `retail_project`.
3. Abrir el archivo `pre-entrega-modulo4.sql`.
4. Ejecutar las consultas una por una o ejecutar el script completo.

# Pre-entrega 5: Análisis avanzado de ventas

Este repositorio contiene una consulta SQL avanzada desarrollada en PostgreSQL para analizar el rendimiento mensual de las categorías de productos mediante CTEs, Window Functions y lógica condicional.

## Archivo principal

- `preentrega_analisis_avanzado.sql`

## Objetivo

Generar un reporte de ventas mensuales por categoría que incluya:

- Mes de la venta.
- Categoría del producto.
- Venta total mensual.
- Ranking de la categoría dentro de cada mes.
- Ventas acumuladas de la categoría a lo largo del tiempo.
- Comparación de la venta mensual contra el promedio histórico de esa categoría.

## Tablas utilizadas

La consulta utiliza las siguientes tablas del proyecto `retail_project`:

- `ventas`
- `productos`
- `categorias`

Relaciones utilizadas:

- `ventas.producto_id` → `productos.producto_id`
- `productos.categoria_id` → `categorias.categoria_id`

El importe de cada venta se calcula con:

```sql
cantidad * precio_unitario
