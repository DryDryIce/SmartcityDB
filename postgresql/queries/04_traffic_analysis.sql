
-- FUENTE DE DATOS:
-- NYC Department of Transportation (NYC DOT)
--
-- TABLAS UTILIZADAS:
-- medicion_trafico: mediciones de velocidad y tiempo de viaje.
-- tramo_vial: información de los tramos monitoreados.
-- ubicacion: distrito al que pertenece cada tramo.
--
-- NOTA:
-- Se excluyen mediciones con velocidad o tiempo de viaje iguales a cero, porque no aportan valores válidos al análisis de velocidad y congestión. La velocidad se conserva en las unidades del dataset.

-- CONSULTA 1: CONGESTIÓN VEHICULAR POR HORA
-- OBJETIVO:
-- Identificar las horas con menor velocidad promedio y mayor tiempo de viaje.

-- INTERPRETACIÓN:
-- Una velocidad promedio menor puede indicar mayor congestión vehicular.

-- Se ordenan los resultados desde la menor velocidad.

SELECT
    EXTRACT(HOUR FROM fecha_hora)::INTEGER AS hora,
    COUNT(*) AS cantidad_mediciones,
    ROUND(AVG(velocidad), 2) AS velocidad_promedio,
    ROUND(AVG(tiempo_viaje), 2) AS tiempo_promedio_seg

FROM medicion_trafico

WHERE velocidad > 0
  AND tiempo_viaje > 0

GROUP BY EXTRACT(HOUR FROM fecha_hora)

ORDER BY velocidad_promedio ASC;


-- CONSULTA 2: CONGESTIÓN VEHICULAR POR DISTRITO

-- OBJETIVO:
-- Comparar las condiciones de movilidad entre distritos.

-- UTILIZA:
-- INNER JOIN para relacionar mediciones, tramos y ubicaciones.
-- GROUP BY para calcular los promedios por distrito.

-- INTERPRETACIÓN:
-- Los distritos con menor velocidad promedio presentan condiciones de circulación potencialmente más congestionadas.

SELECT
    u.distrito,
    COUNT(*) AS cantidad_mediciones,
    ROUND(AVG(m.velocidad), 2) AS velocidad_promedio,
    ROUND(AVG(m.tiempo_viaje), 2) AS tiempo_promedio_seg

FROM medicion_trafico m

INNER JOIN tramo_vial t
    ON m.id_tramo = t.id_tramo

INNER JOIN ubicacion u
    ON t.id_ubicacion = u.id_ubicacion

WHERE m.velocidad > 0
  AND m.tiempo_viaje > 0

GROUP BY u.distrito

ORDER BY velocidad_promedio ASC;


-- CONSULTA 3: TRAMOS VIALES CON MAYOR CONGESTIÓN

-- OBJETIVO:
-- Identificar los 10 tramos con menor velocidad promedio.

-- UTILIZA:
-- INNER JOIN para relacionar las tablas.
-- GROUP BY para agrupar las mediciones por tramo.
-- HAVING para exigir al menos 10 mediciones válidas.
-- LIMIT para mostrar únicamente los primeros 10 resultados.

-- INTERPRETACIÓN:
-- Permite identificar puntos específicos de la red vial donde las velocidades registradas son particularmente bajas.

SELECT
    t.link_name AS tramo_vial,
    u.distrito,
    COUNT(*) AS cantidad_mediciones,
    ROUND(AVG(m.velocidad), 2) AS velocidad_promedio,
    ROUND(AVG(m.tiempo_viaje), 2) AS tiempo_promedio_seg

FROM medicion_trafico m

INNER JOIN tramo_vial t
    ON m.id_tramo = t.id_tramo

INNER JOIN ubicacion u
    ON t.id_ubicacion = u.id_ubicacion

WHERE m.velocidad > 0
  AND m.tiempo_viaje > 0

GROUP BY
    t.id_tramo,
    t.link_name,
    u.distrito

HAVING COUNT(*) >= 10

ORDER BY velocidad_promedio ASC

LIMIT 10;