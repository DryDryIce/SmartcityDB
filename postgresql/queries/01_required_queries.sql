-- 1. Sensores por tipo
SELECT
    c.nombre_categoria,
    COUNT(*) AS cantidad_sensores
FROM sensor s
JOIN categoria_sensor c
    ON s.id_categoria = c.id_categoria
GROUP BY c.nombre_categoria
ORDER BY cantidad_sensores DESC;


-- 2. Sensores por ubicación
SELECT
    u.nombre_zona,
    u.distrito,
    COUNT(s.id_sensor) AS cantidad_sensores
FROM ubicacion u
LEFT JOIN sensor s
    ON u.id_ubicacion = s.id_ubicacion
GROUP BY
    u.id_ubicacion,
    u.nombre_zona,
    u.distrito
ORDER BY cantidad_sensores DESC, u.nombre_zona;


-- 3. Cantidad de sensores activos e inactivos
SELECT
    estado,
    COUNT(*) AS cantidad_sensores
FROM sensor
GROUP BY estado
ORDER BY cantidad_sensores DESC;


-- 4. Número de sensores por organismo responsable
SELECT
    o.nombre AS organismo,
    COUNT(s.id_sensor) AS cantidad_sensores
FROM organismo_responsable o
LEFT JOIN sensor s
    ON o.id_organismo = s.id_organismo
GROUP BY
    o.id_organismo,
    o.nombre
ORDER BY cantidad_sensores DESC, o.nombre;


-- 5. Ubicaciones con mayor cantidad de sensores
SELECT
    u.distrito,
    COUNT(s.id_sensor) AS cantidad_sensores
FROM ubicacion u
LEFT JOIN sensor s
    ON u.id_ubicacion = s.id_ubicacion
GROUP BY u.distrito
ORDER BY cantidad_sensores DESC, u.distrito;

-- 6. Sensores instalados por año
SELECT
    ano_instalacion,
    COUNT(*) AS cantidad_sensores
FROM sensor
GROUP BY ano_instalacion
ORDER BY ano_instalacion;


-- 7. Sensores sin actividad registrada
SELECT
    s.id_sensor,
    s.codigo_fuente,
    s.nombre,
    s.estado
FROM sensor s
WHERE NOT EXISTS (
    SELECT 1
    FROM medicion_ambiental ma
    WHERE ma.id_sensor = s.id_sensor
)
ORDER BY s.id_sensor;


-- 8. Ranking de zonas monitoreadas
SELECT
    u.distrito,
    COUNT(s.id_sensor) AS cantidad_sensores,
    DENSE_RANK() OVER (
        ORDER BY COUNT(s.id_sensor) DESC
    ) AS ranking
FROM ubicacion u
LEFT JOIN sensor s
    ON u.id_ubicacion = s.id_ubicacion
GROUP BY u.distrito
ORDER BY ranking, u.distrito;


-- 9. Vista de detalle de sensores
CREATE OR REPLACE VIEW vista_sensores_detalle AS
SELECT
    s.id_sensor,
    s.codigo_fuente,
    s.nombre AS nombre_sensor,
    s.estado,
    s.ano_instalacion,
    c.nombre_categoria,
    u.nombre_zona,
    u.distrito,
    o.nombre AS organismo
FROM sensor s
JOIN categoria_sensor c
    ON s.id_categoria = c.id_categoria
JOIN ubicacion u
    ON s.id_ubicacion = u.id_ubicacion
LEFT JOIN organismo_responsable o
    ON s.id_organismo = o.id_organismo;

SELECT *
FROM vista_sensores_detalle
ORDER BY distrito, nombre_sensor;


-- 10. Función almacenada: contar sensores por distrito
CREATE OR REPLACE FUNCTION contar_sensores_por_distrito(
    p_distrito VARCHAR
)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_total INTEGER;
BEGIN
    SELECT COUNT(s.id_sensor)
    INTO v_total
    FROM ubicacion u
    LEFT JOIN sensor s
        ON u.id_ubicacion = s.id_ubicacion
    WHERE u.distrito = p_distrito;

    RETURN v_total;
END;
$$;

-- Ejemplo de uso
SELECT contar_sensores_por_distrito('Queens') AS sensores_queens;