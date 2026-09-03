# Proyecto Ventas - Pre-entrega 2 SQL

Proyecto de base de datos para un comercio retail, desarrollado en PostgreSQL.

## Contenido

El archivo `ventas_project.sql`:

- Crea la base de datos `ventas_project`.
- Crea las tablas `clientes`, `productos` y `ventas`.
- Define claves primarias, claves foráneas, restricciones `UNIQUE`, `NOT NULL` y `CHECK`.
- Inserta al menos cinco registros por tabla dentro de una transacción.
- Actualiza precios de productos de Tecnología.
- Elimina una venta de prueba usando `WHERE`.

## Ejecución

Con PostgreSQL instalado, ejecutar:

```bash
psql -U postgres -f retail_project.sql
