-- SMARTCITY DATABASE
-- TABLA: volumen_trafico
-- FUENTE: NYC Automated Traffic Volume Counts
-- PERIODO: Febrero - Julio 2024

CREATE TABLE IF NOT EXISTS volumen_trafico (

    requestid INTEGER,

    boro VARCHAR(30),

    yr SMALLINT,

    m SMALLINT,

    d SMALLINT,

    hh SMALLINT,

    mm SMALLINT,

    vol INTEGER,

    segmentid INTEGER,

    wktgeom TEXT,

    street VARCHAR(255),

    fromst VARCHAR(255),

    tost VARCHAR(255),

    direction VARCHAR(20),

    -- Identificador único generado por PostgreSQL
    id_volumen BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY

);