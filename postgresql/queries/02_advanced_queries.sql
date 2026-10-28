-- 1. CTE: promedio de PM2.5 por zona
WITH promedio_sensor AS (
    SELECT
        s.id_sensor,
        u.distrito,
        AVG(ma.pm25) AS promedio_pm25
    FROM sensor s
    JOIN ubicacion u
        ON s.id_ubicacion = u.id_ubicacion
    JOIN medicion_ambiental ma
        ON s.id_sensor = ma.id_sensor
    WHERE ma.pm25 IS NOT NULL
    GROUP BY
        s.id_sensor,
        u.distrito
)
SELECT
    distrito,
    ROUND(AVG(promedio_pm25), 2) AS pm25_promedio_zona
FROM promedio_sensor
GROUP BY distrito
ORDER BY pm25_promedio_zona DESC;


-- 2. Consulta temporal:
-- temperatura promedio por mes
SELECT
    EXTRACT(MONTH FROM ma.fecha_hora) AS mes,
    ROUND(AVG(ma.temperatura), 2) AS temperatura_promedio
FROM medicion_ambiental ma
WHERE ma.temperatura IS NOT NULL
GROUP BY EXTRACT(MONTH FROM ma.fecha_hora)
ORDER BY mes;


-- 3. Consulta que aprovecha el índice
-- idx_medicion_ambiental_sensor_fecha
EXPLAIN ANALYZE
SELECT
    id_medicion,
    id_sensor,
    fecha_hora,
    pm25
FROM medicion_ambiental
WHERE id_sensor = 6
  AND fecha_hora >= '2024-02-01 00:00:00'
  AND fecha_hora <  '2024-02-02 00:00:00'
ORDER BY fecha_hora;