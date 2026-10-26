use("smartcity_db");

// Índice compuesto para consultas por sensor y fecha
db.lecturas.createIndex(
  {
    id_sensor: 1,
    fecha_hora: 1
  },
  {
    name: "idx_lecturas_sensor_fecha"
  }
);

// Índice compuesto para consultas por zona y fecha
db.lecturas.createIndex(
  {
    zona: 1,
    fecha_hora: 1
  },
  {
    name: "idx_lecturas_zona_fecha"
  }
);

