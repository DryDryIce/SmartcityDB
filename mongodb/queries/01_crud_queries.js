use("smartcity_db");

// FIND

// Buscar todas las lecturas del Bronx
db.lecturas.find({
  zona: "Bronx"
});

// Buscar lecturas de PM2.5
db.lecturas.find({
  tipo_sensor: "PM2.5"
});


// FIND ONE

// Buscar una alerta crítica
db.alertas.findOne({
  nivel: "critico"
});


// UPDATE ONE

// Marcar una alerta como atendida
db.alertas.updateOne(
  {
    tipo_alerta: "pm25_critico",
    zona: "Bronx"
  },
  {
    $set: {
      atendida: true
    }
  }
);


// UPDATE MANY

// Cambiar a cerrado todos los incidentes abiertos de contaminación en Bronx
db.incidentes.updateMany(
  {
    categoria: "contaminacion",
    zona: "Bronx",
    estado: "abierto"
  },
  {
    $set: {
      estado: "cerrado"
    }
  }
);


// DELETE ONE

// Ejemplo académico de eliminación.
// NO ejecutado sobre nuestros documentos actuales, fue utilizado en tablas prueba
db.eventos.deleteOne({
  tipo_evento: "contaminacion_alta",
  zona: "Bronx"
});