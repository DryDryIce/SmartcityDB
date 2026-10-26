INSERT INTO ubicacion (nombre_zona, distrito)
VALUES
    ('Zona general de Manhattan', 'Manhattan'),
    ('Zona general de Brooklyn', 'Brooklyn'),
    ('Zona general de Queens', 'Queens'),
    ('Zona general del Bronx', 'Bronx'),
    ('Zona general de Staten Island', 'Staten Island');

INSERT INTO ubicacion (nombre_zona, distrito, coordenadas)
VALUES
    ('JFK Weather Station', 'Queens', POINT(-73.7622, 40.6386)),
    ('LGA Weather Station', 'Queens', POINT(-73.8803, 40.7794)),
    ('NYC Weather Station', 'Manhattan', POINT(-73.9693, 40.7790)),
    ('JRB Weather Station', 'Manhattan', POINT(-74.0090, 40.7012)),
    ('HPN Weather Station', 'Westchester', POINT(-73.7075, 41.0669)),

    ('EPA Bronx Site 0110', 'Bronx', POINT(-73.9020, 40.8160)),
    ('EPA Bronx Site 0112', 'Bronx', POINT(-73.88553, 40.81551)),
    ('EPA Brooklyn Site 0052', 'Brooklyn', POINT(-74.01871, 40.64182)),
    ('EPA Brooklyn Site 0118', 'Brooklyn', POINT(-73.92769, 40.69454)),
    ('EPA Queens Site 0124', 'Queens', POINT(-73.82153, 40.73614)),
    ('EPA Queens Site 0125', 'Queens', POINT(-73.817694, 40.739264));
    