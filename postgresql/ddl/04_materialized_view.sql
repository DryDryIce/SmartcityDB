CREATE MATERIALIZED VIEW mv_pm25_promedio_por_zona AS
SELECT
    u.distrito,
    ROUND(AVG(ma.pm25), 2) AS pm25_promedio,
    COUNT(ma.id_medicion) AS cantidad_lecturas
FROM medicion_ambiental ma
JOIN sensor s
    ON ma.id_sensor = s.id_sensor
JOIN ubicacion u
    ON s.id_ubicacion = u.id_ubicacion
WHERE ma.pm25 IS NOT NULL
GROUP BY u.distrito;


-- Consultar la vista materializada
SELECT *
FROM mv_pm25_promedio_por_zona
ORDER BY pm25_promedio DESC;


-- Actualizar la vista si cambian los datos base
REFRESH MATERIALIZED VIEW mv_pm25_promedio_por_zona;