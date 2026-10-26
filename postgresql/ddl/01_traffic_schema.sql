CREATE TABLE ubicacion (
    id_ubicacion SERIAL PRIMARY KEY,
    nombre_zona VARCHAR(150) NOT NULL,
    distrito VARCHAR(100) NOT NULL,
    coordenadas POINT,

    CONSTRAINT uq_ubicacion
        UNIQUE (nombre_zona, distrito)
);

CREATE TABLE tramo_vial (
    id_tramo SERIAL PRIMARY KEY,
    source_id INTEGER NOT NULL UNIQUE,
    link_id BIGINT NOT NULL UNIQUE,
    link_name VARCHAR(255) NOT NULL,
    owner VARCHAR(150),
    transcom_id VARCHAR(100),
    link_points TEXT,
    id_ubicacion INTEGER NOT NULL,

    CONSTRAINT fk_tramo_ubicacion
        FOREIGN KEY (id_ubicacion)
        REFERENCES ubicacion(id_ubicacion)
);

CREATE TABLE medicion_trafico (
    id_medicion BIGSERIAL PRIMARY KEY,
    id_tramo INTEGER NOT NULL,
    fecha_hora TIMESTAMP NOT NULL,
    velocidad NUMERIC(6,2) NOT NULL,
    tiempo_viaje INTEGER NOT NULL,
    status INTEGER NOT NULL,

    CONSTRAINT fk_medicion_tramo
        FOREIGN KEY (id_tramo)
        REFERENCES tramo_vial(id_tramo)
);