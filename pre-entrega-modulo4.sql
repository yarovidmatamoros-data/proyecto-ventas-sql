-- PRE-ENTREGA MÓDULO 4: Consultas multicapa para análisis de negocio

-- 1. RENTABILIDAD POR CATEGORÍA
-- Problema de negocio: permite identificar las categorías que generan mayor volumen de ventas e ingresos, para priorizar stock y promociones. Umbral definido en 2 unidades porque se descartan categorías con ventas aisladas.

SELECT cat.nombre AS categoria,
       SUM(v.cantidad) AS unidades_vendidas,
       SUM(v.cantidad * v.precio_unitario) AS ingreso_total
FROM ventas AS v
INNER JOIN productos AS p
    ON v.producto_id = p.producto_id
INNER JOIN categorias AS cat
    ON p.categoria_id = cat.categoria_id
GROUP BY cat.nombre
HAVING SUM(v.cantidad) > 2
ORDER BY ingreso_total DESC;


-- 2. CLIENTES SIN COMPRAS
-- Problema de negocio: permite detectar clientes registrados que aún no compraron, para enviarles una promoción de bienvenida o seguimiento comercial.

SELECT c.cliente_id,
       c.nombre AS cliente,
       c.email,
       COALESCE(SUM(v.cantidad), 0) AS unidades_compradas
FROM clientes AS c
LEFT JOIN ventas AS v
    ON c.cliente_id = v.cliente_id
GROUP BY c.cliente_id, c.nombre, c.email
HAVING COUNT(v.venta_id) = 0
ORDER BY c.nombre;

-- 3. TOP DE COMPRAS POR CLIENTE
-- Problema de negocio: identifica el producto que cada cliente compró más veces y la fecha de su última operación, para personalizar recomendaciones y campañas.

WITH compras_por_producto AS (
    SELECT c.cliente_id,
           c.nombre AS cliente,
           p.producto_id,
           p.nombre AS producto,
           COUNT(v.venta_id) AS veces_comprado,
           MAX(v.fecha_venta) AS ultima_transaccion
    FROM clientes AS c
    INNER JOIN ventas AS v
        ON c.cliente_id = v.cliente_id
    INNER JOIN productos AS p
        ON v.producto_id = p.producto_id
    GROUP BY c.cliente_id, c.nombre, p.producto_id, p.nombre
),
ranking_compras AS (
    SELECT cpp.cliente,
           cpp.producto,
           cpp.veces_comprado,
           cpp.ultima_transaccion,
           ROW_NUMBER() OVER (
               PARTITION BY cpp.cliente_id
               ORDER BY cpp.veces_comprado DESC,
                        cpp.ultima_transaccion DESC
           ) AS posicion
    FROM compras_por_producto AS cpp
)
SELECT rc.cliente,
       rc.producto AS producto_mas_comprado,
       rc.veces_comprado,
       rc.ultima_transaccion
FROM ranking_compras AS rc
WHERE rc.posicion = 1
ORDER BY rc.cliente;
