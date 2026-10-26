-- =========================================================
-- COBERTURA DE OPERADORES SQL - SMARTCITY
-- =========================================================


-- 1. DISTINCT
-- Distritos diferentes donde existen sensores
SELECT DISTINCT
    u.distrito
FROM ubicacion u
JOIN sensor s
    ON u.id_ubicacion = s.id_ubicacion
ORDER BY u.distrito;


-- 2. HAVING
-- Distritos que tienen más de un sensor
SELECT
    u.distrito,
    COUNT(s.id_sensor) AS cantidad_sensores
FROM ubicacion u
JOIN sensor s
    ON u.id_ubicacion = s.id_ubicacion
GROUP BY u.distrito
HAVING COUNT(s.id_sensor) > 1
ORDER BY cantidad_sensores DESC;


-- 3. MIN, MAX y AVG
-- Estadísticas de PM2.5 por distrito
SELECT
    u.distrito,
    ROUND(MIN(ma.pm25), 2) AS pm25_minimo,
    ROUND(MAX(ma.pm25), 2) AS pm25_maximo,
    ROUND(AVG(ma.pm25), 2) AS pm25_promedio
FROM medicion_ambiental ma
JOIN sensor s
    ON ma.id_sensor = s.id_sensor
JOIN ubicacion u
    ON s.id_ubicacion = u.id_ubicacion
WHERE ma.pm25 IS NOT NULL
GROUP BY u.distrito
ORDER BY u.distrito;


-- 4. SUM
-- Suma total del tiempo de viaje registrado por distrito
SELECT
    borough AS distrito,
    ROUND(SUM(tiempo_viaje_seg), 2) AS tiempo_viaje_total_segundos
FROM medicion_trafico_historico
WHERE tiempo_viaje_seg IS NOT NULL
GROUP BY borough
ORDER BY tiempo_viaje_total_segundos DESC;