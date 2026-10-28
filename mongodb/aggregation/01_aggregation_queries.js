use("smartcity_db");

// 1. Promedio de PM2.5 por zona

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
      minimo_pm25: {
        $min: "$mediciones.pm25"
      },
      maximo_pm25: {
        $max: "$mediciones.pm25"
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


// 2. Estadisticas por tipo de sensor

db.lecturas.aggregate([
  {
    $group: {
      _id: "$tipo_sensor",

      cantidad_lecturas: {
        $sum: 1
      },

      promedio_pm25: {
        $avg: "$mediciones.pm25"
      },

      promedio_temperatura: {
        $avg: "$mediciones.temperatura"
      },

      promedio_humedad: {
        $avg: "$mediciones.humedad"
      }
    }
  },
  {
    $sort: {
      cantidad_lecturas: -1
    }
  }
]);


// 3. Ranking de zonas por actividad

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


// 4. Lecturas reales vs sinteticas

db.lecturas.aggregate([
  {
    $group: {
      _id: "$sintetico",
      cantidad: {
        $sum: 1
      }
    }
  },
  {
    $sort: {
      _id: 1
    }
  }
]);


// 5. Promedio mensual de PM2.5

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
      _id: {
        anio: {
          $year: "$fecha_hora"
        },
        mes: {
          $month: "$fecha_hora"
        }
      },
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
      "_id.anio": 1,
      "_id.mes": 1
    }
  }
]);