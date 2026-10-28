-- DEMOSTRACION DE PARTICIONAMIENTO POR FECHA

CREATE TABLE medicion_ambiental_part (
    id_medicion BIGINT,
    id_sensor INTEGER NOT NULL,
    fecha_hora TIMESTAMP NOT NULL,
    temperatura NUMERIC(6,2),
    humedad NUMERIC(6,2),
    pm25 NUMERIC(8,3),
    precipitacion NUMERIC(8,3),
    velocidad_viento NUMERIC(8,3),
    direccion_viento NUMERIC(6,2),
    presion NUMERIC(8,2)
)
PARTITION BY RANGE (fecha_hora);


CREATE TABLE medicion_ambiental_2024_q1
PARTITION OF medicion_ambiental_part
FOR VALUES FROM ('2024-01-01') TO ('2024-04-01');


CREATE TABLE medicion_ambiental_2024_q2
PARTITION OF medicion_ambiental_part
FOR VALUES FROM ('2024-04-01') TO ('2024-07-01');


CREATE TABLE medicion_ambiental_2024_q3
PARTITION OF medicion_ambiental_part
FOR VALUES FROM ('2024-07-01') TO ('2024-10-01');


INSERT INTO medicion_ambiental_part
SELECT
    id_medicion,
    id_sensor,
    fecha_hora,
    temperatura,
    humedad,
    pm25,
    precipitacion,
    velocidad_viento,
    direccion_viento,
    presion
FROM medicion_ambiental;


-- Verificar distribución de registros
SELECT
    tableoid::regclass AS particion,
    COUNT(*) AS cantidad
FROM medicion_ambiental_part
GROUP BY tableoid
ORDER BY particion;