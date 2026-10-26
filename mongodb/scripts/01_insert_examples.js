use("smartcity_db");

// Documento de ejemplo: lecturas
db.lecturas.insertOne({
  id_sensor: "EPA-BRONX-0110",
  tipo_sensor: "PM2.5",
  zona: "Bronx",
  fecha_hora: new Date("2024-02-01T10:00:00"),
  mediciones: {
    pm25: 7.8
  },
  estado: "normal",
  fuente: "EPA"
});

// Documento de ejemplo: eventos
db.eventos.insertOne({
  tipo_evento: "contaminacion_alta",
  zona: "Bronx",
  fecha_hora: new Date("2024-02-01T10:15:00"),
  severidad: "alta",
  sensor_relacionado: "EPA-BRONX-0110",
  detalle: {
    pm25: 42.6,
    umbral: 35.0
  },
  estado: "detectado"
});

// Documento de ejemplo: alertas
db.alertas.insertOne({
  tipo_alerta: "pm25_critico",
  zona: "Bronx",
  fecha_hora: new Date("2024-02-01T10:20:00"),
  nivel: "critico",
  sensor_relacionado: "EPA-BRONX-0110",
  mensaje: "Nivel de PM2.5 por encima del umbral permitido",
  datos: {
    pm25: 42.6,
    umbral: 35.0
  },
  atendida: false
});

// Documento de ejemplo: incidentes
db.incidentes.insertOne({
  categoria: "contaminacion",
  zona: "Bronx",
  fecha_hora: new Date("2024-02-01T10:30:00"),
  descripcion: "Se detectó un episodio de contaminación asociado a niveles elevados de PM2.5",
  sensor_relacionado: "EPA-BRONX-0110",
  prioridad: "alta",
  estado: "abierto",
  acciones: [
    "Verificar medición del sensor",
    "Notificar al organismo responsable"
  ]
});