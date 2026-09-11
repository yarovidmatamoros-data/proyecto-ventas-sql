-- MÓDULO 5: Informe de rendimiento regional con CTE.
-- Problema de negocio: permite comparar el ingreso total de cada región e identificar cuáles superan el promedio de ventas regional.
WITH ventas_por_region AS (
    SELECT r.nombre AS region,
           SUM(v.cantidad * v.precio_unitario) AS total_ventas
    FROM ventas AS v
    INNER JOIN clientes AS c
        ON v.cliente_id = c.cliente_id
    INNER JOIN regiones AS r
        ON c.region_id = r.region_id
    GROUP BY r.nombre
)

SELECT vpr.region,
       vpr.total_ventas
FROM ventas_por_region AS vpr
WHERE vpr.total_ventas > (
    SELECT AVG(vpr_promedio.total_ventas)
    FROM ventas_por_region AS vpr_promedio
)
ORDER BY vpr.total_ventas DESC;
