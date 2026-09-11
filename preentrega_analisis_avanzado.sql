-- PRE-ENTREGA: Análisis avanzado de ventas con CTEs y Window Functions.
-- El reporte analiza las ventas mensuales por categoría, identifica el ranking de cada categoría, calcula ventas acumuladas y compara cada mes con su promedio histórico.

-- Primera CTE: agrupa las ventas al nivel de mes y categoría.
WITH ventas_mensuales AS (
    SELECT DATE_TRUNC('month', v.fecha_venta)::DATE AS mes,
           cat.nombre AS categoria,
           SUM(v.cantidad * v.precio_unitario) AS venta_total
    FROM ventas AS v
    INNER JOIN productos AS p
        ON v.producto_id = p.producto_id
    INNER JOIN categorias AS cat
        ON p.categoria_id = cat.categoria_id
    GROUP BY DATE_TRUNC('month', v.fecha_venta)::DATE,
             cat.nombre
),

-- Segunda CTE: calcula métricas de ventana sobre las ventas mensuales.
metricas_ventana AS (
    SELECT vm.mes,
           vm.categoria,
           vm.venta_total,

           -- Posición de cada categoría según sus ventas en cada mes.
           RANK() OVER (
               PARTITION BY vm.mes
               ORDER BY vm.venta_total DESC
           ) AS ranking_categoria,

           -- Suma progresiva de las ventas de cada categoría a través de los meses.
           SUM(vm.venta_total) OVER (
               PARTITION BY vm.categoria
               ORDER BY vm.mes
               ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
           ) AS ventas_acumuladas
    FROM ventas_mensuales AS vm
)

-- Consulta final: compara la venta mensual contra el promedio histórico
-- de la misma categoría y clasifica su rendimiento.
SELECT mv.mes,
       mv.categoria,
       mv.venta_total,
       mv.ranking_categoria,
       mv.ventas_acumuladas,
       CASE
           WHEN mv.venta_total >= (
               SELECT AVG(vm_promedio.venta_total)
               FROM ventas_mensuales AS vm_promedio
               WHERE vm_promedio.categoria = mv.categoria
           )
           THEN 'Exitoso'
           ELSE 'Bajo el promedio'
       END AS comparativa
FROM metricas_ventana AS mv
ORDER BY mv.mes,
         mv.ranking_categoria;
