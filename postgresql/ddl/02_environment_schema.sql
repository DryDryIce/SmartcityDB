CREATE TABLE categoria_sensor (
    id_categoria SERIAL PRIMARY KEY,
    nombre_categoria VARCHAR(100) NOT NULL UNIQUE,
    descripcion VARCHAR(255)
);


CREATE TABLE organismo_responsable (
    id_organismo SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL UNIQUE,
    responsable VARCHAR(150)
);


CREATE TABLE sensor (
    id_sensor SERIAL PRIMARY KEY,
    codigo_fuente VARCHAR(100) NOT NULL UNIQUE,
    nombre VARCHAR(150) NOT NULL,
    fecha_instalacion DATE,
    ano_instalacion INTEGER,
    estado VARCHAR(20) NOT NULL,
    id_categoria INTEGER NOT NULL,
    id_ubicacion INTEGER NOT NULL,
    id_organismo INTEGER,

    CONSTRAINT fk_sensor_categoria
        FOREIGN KEY (id_categoria)
        REFERENCES categoria_sensor(id_categoria),

    CONSTRAINT fk_sensor_ubicacion
        FOREIGN KEY (id_ubicacion)
        REFERENCES ubicacion(id_ubicacion),

    CONSTRAINT fk_sensor_organismo
        FOREIGN KEY (id_organismo)
        REFERENCES organismo_responsable(id_organismo),

    CONSTRAINT chk_sensor_estado
        CHECK (estado IN ('activo', 'inactivo', 'mantenimiento'))
);


CREATE TABLE medicion_ambiental (
    id_medicion BIGSERIAL PRIMARY KEY,
    id_sensor INTEGER NOT NULL,
    fecha_hora TIMESTAMP NOT NULL,
    temperatura NUMERIC(6,2),
    humedad NUMERIC(6,2),
    pm25 NUMERIC(8,3),
    precipitacion NUMERIC(8,3),
    velocidad_viento NUMERIC(8,3),
    direccion_viento NUMERIC(6,2),
    presion NUMERIC(8,2),

    CONSTRAINT fk_medicion_ambiental_sensor
        FOREIGN KEY (id_sensor)
        REFERENCES sensor(id_sensor),

    CONSTRAINT chk_humedad
        CHECK (humedad IS NULL OR (humedad >= 0 AND humedad <= 100)),

    CONSTRAINT chk_pm25
        CHECK (pm25 IS NULL OR pm25 >= 0),

    CONSTRAINT chk_precipitacion
        CHECK (precipitacion IS NULL OR precipitacion >= 0)
);


CREATE INDEX idx_medicion_ambiental_sensor_fecha
ON medicion_ambiental (id_sensor, fecha_hora);