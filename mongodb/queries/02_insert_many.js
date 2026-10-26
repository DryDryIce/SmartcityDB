use("smartcity_db");

// Insertar varias lecturas de ejemplo
db.lecturas.insertMany([
  {
    id_sensor: "EPA-BRONX-0110",
    tipo_sensor: "PM2.5",
    zona: "Bronx",
    fecha_hora: new Date("2024-02-01T11:00:00"),
    mediciones: {
      pm25: 8.4
    },
    estado: "normal",
    fuente: "EPA"
  },
  {
    id_sensor: "EPA-BROOKLYN-0052",
    tipo_sensor: "PM2.5",
    zona: "Brooklyn",
    fecha_hora: new Date("2024-02-01T11:00:00"),
    mediciones: {
      pm25: 10.1
    },
    estado: "normal",
    fuente: "EPA"
  },
  {
    id_sensor: "JFK",
    tipo_sensor: "Meteorológico",
    zona: "Queens",
    fecha_hora: new Date("2024-02-01T11:00:00"),
    mediciones: {
      temperatura: 4.8,
      humedad: 71.2,
      precipitacion: 0.0,
      velocidad_viento: 9.5
    },
    estado: "normal",
    fuente: "IEM"
  }
]);