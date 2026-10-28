-- ARCHIVO: 05_traffic_volume_analysis.sql
-- TEMA: Analisis de volumen vehicular
-- FUENTE: NYC Automated Traffic Volume Counts
-- PERIODO: Febrero - Julio 2024

-- CONSULTA 1: VOLUMEN VEHICULAR POR DISTRITO

SELECT
    boro AS distrito,
    COUNT(*) AS cantidad_mediciones,
    COUNT(DISTINCT segmentid) AS tramos_monitoreados,
    COUNT(DISTINCT requestid) AS solicitudes_conteo,
    SUM(vol) AS volumen_total,
    ROUND(AVG(vol), 2) AS promedio_vehiculos_intervalo,
    MAX(vol) AS maximo_vehiculos_intervalo

FROM volumen_trafico

WHERE vol >= 0

GROUP BY boro

ORDER BY promedio_vehiculos_intervalo DESC;


-- CONSULTA 2: RUTAS CON MAYOR VOLUMEN VEHICULAR

SELECT
    boro AS distrito,
    segmentid AS id_segmento,
    street AS calle,
    fromst AS desde,
    tost AS hasta,
    direction AS direccion,
    COUNT(*) AS cantidad_mediciones,
    SUM(vol) AS volumen_total,
    ROUND(AVG(vol), 2) AS promedio_vehiculos_intervalo,
    MAX(vol) AS maximo_vehiculos_intervalo

FROM volumen_trafico

WHERE vol >= 0

GROUP BY
    boro,
    segmentid,
    street,
    fromst,
    tost,
    direction

HAVING COUNT(*) >= 10

ORDER BY promedio_vehiculos_intervalo DESC

LIMIT 10;