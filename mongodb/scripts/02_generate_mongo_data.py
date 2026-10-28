import csv
import json
from datetime import datetime, timedelta
from pathlib import Path


# CONFIGURACION

TARGET_DOCUMENTS = 500_000

BASE_DIR = Path(__file__).resolve().parents[2]

WEATHER_FILE = (
    BASE_DIR
    / "data"
    / "processed"
    / "weather"
    / "weather_postgresql.csv"
)

EPA_FILE = (
    BASE_DIR
    / "data"
    / "processed"
    / "air_quality"
    / "epa_postgresql.csv"
)

OUTPUT_DIR = BASE_DIR / "data" / "synthetic" / "mongodb"
OUTPUT_FILE = OUTPUT_DIR / "lecturas_500k.jsonl"


# Informacion que ya definimos para nuestros sensores
SENSORES = {
    1: {
        "codigo": "JFK",
        "tipo": "Meteorológico",
        "zona": "Queens",
        "fuente": "IEM",
    },
    2: {
        "codigo": "LGA",
        "tipo": "Meteorológico",
        "zona": "Queens",
        "fuente": "IEM",
    },
    3: {
        "codigo": "NYC",
        "tipo": "Meteorológico",
        "zona": "Manhattan",
        "fuente": "IEM",
    },
    4: {
        "codigo": "JRB",
        "tipo": "Meteorológico",
        "zona": "Manhattan",
        "fuente": "IEM",
    },
    5: {
        "codigo": "HPN",
        "tipo": "Meteorológico",
        "zona": "Westchester",
        "fuente": "IEM",
    },
    6: {
        "codigo": "EPA-BRONX-0110",
        "tipo": "PM2.5",
        "zona": "Bronx",
        "fuente": "EPA",
    },
    7: {
        "codigo": "EPA-BRONX-0112",
        "tipo": "PM2.5",
        "zona": "Bronx",
        "fuente": "EPA",
    },
    8: {
        "codigo": "EPA-BROOKLYN-0052",
        "tipo": "PM2.5",
        "zona": "Brooklyn",
        "fuente": "EPA",
    },
    9: {
        "codigo": "EPA-BROOKLYN-0118",
        "tipo": "PM2.5",
        "zona": "Brooklyn",
        "fuente": "EPA",
    },
    10: {
        "codigo": "EPA-QUEENS-0124",
        "tipo": "PM2.5",
        "zona": "Queens",
        "fuente": "EPA",
    },
    11: {
        "codigo": "EPA-QUEENS-0125",
        "tipo": "PM2.5",
        "zona": "Queens",
        "fuente": "EPA",
    },
}


# FUNCIONES AUXILIARES

def numero_o_none(valor):
    """Convierte una celda numerica a float o None."""
    if valor is None:
        return None

    valor = str(valor).strip()

    if valor == "":
        return None

    try:
        return float(valor)
    except ValueError:
        return None


def convertir_fecha(valor):
    """Convierte el texto del CSV a datetime."""
    valor = valor.strip()

    formatos = [
    "%Y-%m-%d %H:%M",
    "%Y-%m-%d %H:%M:%S",
    "%Y-%m-%dT%H:%M",
    "%Y-%m-%dT%H:%M:%S",
    "%Y-%m-%d %H:%M:%S.%f",
    ]

    for formato in formatos:
        try:
            return datetime.strptime(valor, formato)
        except ValueError:
            pass

    raise ValueError(f"Formato de fecha no reconocido: {valor}")


def crear_mediciones(fila):
    """
    Crea un objeto documental flexible.
    Solo agrega las variables que realmente existen.
    """
    mediciones = {}

    variables = [
        "temperatura",
        "humedad",
        "pm25",
        "precipitacion",
        "velocidad_viento",
        "direccion_viento",
        "presion",
    ]

    for variable in variables:
        valor = numero_o_none(fila.get(variable))

        if valor is not None:
            mediciones[variable] = valor

    return mediciones


def cargar_archivo(ruta):
    documentos = []

    with ruta.open("r", encoding="utf-8-sig", newline="") as archivo:
        lector = csv.DictReader(archivo)

        for fila in lector:
            id_sensor = int(fila["id_sensor"])
            sensor = SENSORES[id_sensor]

            fecha = convertir_fecha(fila["fecha_hora"])

            documento = {
                "id_sensor": sensor["codigo"],
                "tipo_sensor": sensor["tipo"],
                "zona": sensor["zona"],

                # Primero se exporta como ISO.
                # Luego MongoDB lo convertira a Date.
                "fecha_hora": fecha.isoformat(),

                "mediciones": crear_mediciones(fila),
                "estado": "normal",
                "fuente": sensor["fuente"],

                # Permite distinguir datos originales
                # de los generados posteriormente.
                "sintetico": False,
            }

            documentos.append(documento)

    return documentos


# CARGA DE DATOS REALES

print("Cargando datos meteorologicos...")
documentos_reales = cargar_archivo(WEATHER_FILE)

print("Cargando datos EPA...")
documentos_reales.extend(cargar_archivo(EPA_FILE))

print(f"Documentos reales cargados: {len(documentos_reales):,}")


# GENERACION SINTETICA

documentos_finales = list(documentos_reales)

indice = 0

while len(documentos_finales) < TARGET_DOCUMENTS:
    original = documentos_reales[indice % len(documentos_reales)]

    copia = {
        "id_sensor": original["id_sensor"],
        "tipo_sensor": original["tipo_sensor"],
        "zona": original["zona"],
        "mediciones": dict(original["mediciones"]),
        "estado": original["estado"],
        "fuente": original["fuente"],
        "sintetico": True,
    }

    fecha_original = datetime.fromisoformat(original["fecha_hora"])

    # Cada repeticion obtiene un pequeño desplazamiento temporal
    # para no generar documentos completamente identicos.
    desplazamiento = (indice // len(documentos_reales)) + 1

    fecha_sintetica = fecha_original + timedelta(minutes=desplazamiento)

    copia["fecha_hora"] = fecha_sintetica.isoformat()

    documentos_finales.append(copia)

    indice += 1


# EXPORTACION JSON LINES

OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

with OUTPUT_FILE.open("w", encoding="utf-8") as archivo:
    for documento in documentos_finales:
        archivo.write(
            json.dumps(
                documento,
                ensure_ascii=False
            )
            + "\n"
        )


print()
print("==============================================")
print("GENERACION COMPLETADA")
print("==============================================")
print(f"Documentos totales: {len(documentos_finales):,}")
print(f"Documentos reales:  {len(documentos_reales):,}")
print(
    f"Documentos sinteticos: "
    f"{len(documentos_finales) - len(documentos_reales):,}"
)
print()
print(f"Archivo generado:")
print(OUTPUT_FILE)