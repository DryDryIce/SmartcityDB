INSERT INTO sensor (
    codigo_fuente,
    nombre,
    fecha_instalacion,
    ano_instalacion,
    estado,
    id_categoria,
    id_ubicacion,
    id_organismo
)
VALUES
    (
        'JFK',
        'JFK Weather Station',
        NULL,
        1948,
        'activo',
        (SELECT id_categoria FROM categoria_sensor WHERE nombre_categoria = 'Meteorológico'),
        (SELECT id_ubicacion FROM ubicacion WHERE nombre_zona = 'JFK Weather Station'),
        (SELECT id_organismo FROM organismo_responsable WHERE nombre = 'IEM')
    ),
    (
        'LGA',
        'LGA Weather Station',
        NULL,
        1935,
        'activo',
        (SELECT id_categoria FROM categoria_sensor WHERE nombre_categoria = 'Meteorológico'),
        (SELECT id_ubicacion FROM ubicacion WHERE nombre_zona = 'LGA Weather Station'),
        (SELECT id_organismo FROM organismo_responsable WHERE nombre = 'IEM')
    ),
    (
        'NYC',
        'NYC Weather Station',
        NULL,
        1943,
        'activo',
        (SELECT id_categoria FROM categoria_sensor WHERE nombre_categoria = 'Meteorológico'),
        (SELECT id_ubicacion FROM ubicacion WHERE nombre_zona = 'NYC Weather Station'),
        (SELECT id_organismo FROM organismo_responsable WHERE nombre = 'IEM')
    ),
    (
        'JRB',
        'JRB Weather Station',
        NULL,
        2016,
        'activo',
        (SELECT id_categoria FROM categoria_sensor WHERE nombre_categoria = 'Meteorológico'),
        (SELECT id_ubicacion FROM ubicacion WHERE nombre_zona = 'JRB Weather Station'),
        (SELECT id_organismo FROM organismo_responsable WHERE nombre = 'IEM')
    ),
    (
        'HPN',
        'HPN Weather Station',
        NULL,
        1948,
        'activo',
        (SELECT id_categoria FROM categoria_sensor WHERE nombre_categoria = 'Meteorológico'),
        (SELECT id_ubicacion FROM ubicacion WHERE nombre_zona = 'HPN Weather Station'),
        (SELECT id_organismo FROM organismo_responsable WHERE nombre = 'IEM')
    ),

    (
        'EPA-BRONX-0110',
        'EPA PM2.5 Bronx Site 0110',
        NULL,
        2018,
        'activo',
        (SELECT id_categoria FROM categoria_sensor WHERE nombre_categoria = 'PM2.5'),
        (SELECT id_ubicacion FROM ubicacion WHERE nombre_zona = 'EPA Bronx Site 0110'),
        (SELECT id_organismo FROM organismo_responsable WHERE nombre = 'EPA')
    ),
    (
        'EPA-BRONX-0112',
        'EPA PM2.5 Bronx Site 0112',
        NULL,
        2020,
        'activo',
        (SELECT id_categoria FROM categoria_sensor WHERE nombre_categoria = 'PM2.5'),
        (SELECT id_ubicacion FROM ubicacion WHERE nombre_zona = 'EPA Bronx Site 0112'),
        (SELECT id_organismo FROM organismo_responsable WHERE nombre = 'EPA')
    ),
    (
        'EPA-BROOKLYN-0052',
        'EPA PM2.5 Brooklyn Site 0052',
        NULL,
        2017,
        'activo',
        (SELECT id_categoria FROM categoria_sensor WHERE nombre_categoria = 'PM2.5'),
        (SELECT id_ubicacion FROM ubicacion WHERE nombre_zona = 'EPA Brooklyn Site 0052'),
        (SELECT id_organismo FROM organismo_responsable WHERE nombre = 'EPA')
    ),
    (
        'EPA-BROOKLYN-0118',
        'EPA PM2.5 Brooklyn Site 0118',
        NULL,
        2021,
        'activo',
        (SELECT id_categoria FROM categoria_sensor WHERE nombre_categoria = 'PM2.5'),
        (SELECT id_ubicacion FROM ubicacion WHERE nombre_zona = 'EPA Brooklyn Site 0118'),
        (SELECT id_organismo FROM organismo_responsable WHERE nombre = 'EPA')
    ),
    (
        'EPA-QUEENS-0124',
        'EPA PM2.5 Queens Site 0124',
        NULL,
        2019,
        'activo',
        (SELECT id_categoria FROM categoria_sensor WHERE nombre_categoria = 'PM2.5'),
        (SELECT id_ubicacion FROM ubicacion WHERE nombre_zona = 'EPA Queens Site 0124'),
        (SELECT id_organismo FROM organismo_responsable WHERE nombre = 'EPA')
    ),
    (
        'EPA-QUEENS-0125',
        'EPA PM2.5 Queens Site 0125',
        NULL,
        2022,
        'activo',
        (SELECT id_categoria FROM categoria_sensor WHERE nombre_categoria = 'PM2.5'),
        (SELECT id_ubicacion FROM ubicacion WHERE nombre_zona = 'EPA Queens Site 0125'),
        (SELECT id_organismo FROM organismo_responsable WHERE nombre = 'EPA')
    );
    