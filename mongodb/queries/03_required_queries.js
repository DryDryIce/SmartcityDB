use("smartcity_db");


// 1. Lecturas de un sensor especifico

db.lecturas.find({
  id_sensor: "EPA-BRONX-0110"
});


// 2. Lecturas dentro de un rango de fechas

db.lecturas.find({
  id_sensor: "EPA-BRONX-0110",
  fecha_hora: {
    $gte: new Date("2024-02-01T00:00:00Z"),
    $lt: new Date("2024-02-02T00:00:00Z")
  }
});


// 3. Valor maximo y minimo de PM2.5

db.lecturas.aggregate([
  {
    $match: {
      "mediciones.pm25": {
        $exists: true
      }
    }
  },
  {
    $group: {
      _id: null,
      pm25_maximo: {
        $max: "$mediciones.pm25"
      },
      pm25_minimo: {
        $min: "$mediciones.pm25"
      }
    }
  }
]);


// 4. Eventos criticos

db.eventos.find({
  severidad: "alta"
});


// 5. Alertas por zona geografica

db.alertas.find({
  zona: "Bronx"
});

// 6. Promedio de mediciones por zona

db.lecturas.aggregate([
  {
    $match: {
      "mediciones.pm25": {
        $exists: true
      }
    }
  },
  {
    $group: {
      _id: "$zona",
      promedio_pm25: {
        $avg: "$mediciones.pm25"
      },
      cantidad_lecturas: {
        $sum: 1
      }
    }
  },
  {
    $sort: {
      promedio_pm25: -1
    }
  }
]);


// 7. Promedio por tipo de sensor

db.lecturas.aggregate([
  {
    $group: {
      _id: "$tipo_sensor",

      promedio_pm25: {
        $avg: "$mediciones.pm25"
      },

      promedio_temperatura: {
        $avg: "$mediciones.temperatura"
      },

      promedio_humedad: {
        $avg: "$mediciones.humedad"
      },

      cantidad_lecturas: {
        $sum: 1
      }
    }
  },
  {
    $sort: {
      cantidad_lecturas: -1
    }
  }
]);


// 8. Incidentes por categoria

db.incidentes.aggregate([
  {
    $group: {
      _id: "$categoria",
      cantidad_incidentes: {
        $sum: 1
      }
    }
  },
  {
    $sort: {
      cantidad_incidentes: -1
    }
  }
]);


// 9. Aggregation Framework:
// ranking de zonas por cantidad de lecturas

db.lecturas.aggregate([
  {
    $group: {
      _id: "$zona",
      cantidad_lecturas: {
        $sum: 1
      }
    }
  },
  {
    $sort: {
      cantidad_lecturas: -1
    }
  }
]);


// 10. Consulta con multiples filtros

db.lecturas.find({
  zona: "Queens",
  tipo_sensor: "PM2.5",
  fecha_hora: {
    $gte: new Date("2024-02-01T00:00:00Z"),
    $lt: new Date("2024-03-01T00:00:00Z")
  },
  "mediciones.pm25": {
    $gte: 5
  }
});

