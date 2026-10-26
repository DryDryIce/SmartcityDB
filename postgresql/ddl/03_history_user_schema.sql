CREATE TABLE medicion_trafico_historico (
    id_medicion BIGSERIAL PRIMARY KEY,
    sid INTEGER NOT NULL,
    link_name VARCHAR(255) NOT NULL,
    borough VARCHAR(100) NOT NULL,
    fecha_hora TIMESTAMP NOT NULL,
    tiempo_viaje_seg NUMERIC(10,2),
    velocidad_fps NUMERIC(10,2),

    CONSTRAINT chk_tiempo_viaje_hist
        CHECK (tiempo_viaje_seg IS NULL OR tiempo_viaje_seg >= 0),

    CONSTRAINT chk_velocidad_hist
        CHECK (velocidad_fps IS NULL OR velocidad_fps >= 0)
);

CREATE INDEX idx_trafico_historico_borough_fecha
ON medicion_trafico_historico (borough, fecha_hora);


CREATE TABLE usuario (
    id_usuario SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    correo VARCHAR(200) NOT NULL UNIQUE
);