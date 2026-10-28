use("smartcity_db");

// Ejemplo de filtro + proyección
db.lecturas.find(
  { zona: "Bronx" },
  {
    _id: 0,
    id_sensor: 1,
    fecha_hora: 1,
    "mediciones.pm25": 1
  }
).limit(5);