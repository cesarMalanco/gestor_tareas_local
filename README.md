# Gestor de tareas local con SQLite

## Descripción del proyecto
El presente proyecto consiste en un gestor de tareas con persistencia
local de datos mediante el gestor SQLite.

El gestor permite agregar, consultar, editar, marcar como completadas y
eliminar tareas, conservando la información después de cerrar y volver a abrir la aplicación.

Está diseñado para ejecutarse tanto en Android, iOS, Windows, Linux,
macOS y web, esto sin depender de un servidor externo ni de una conexión
a internet para almacenar los datos.

## Tecnología de persistencia
Para implementar la persistencia local se eligió SQLite como motor de bases
de datos para almacenar la información de manera local sin necesidad de un
servidor independiente; Drift como biblioteca de persistencia para Dart con
el fin de poder definir tablas, realizar operaciones CRUD y realizar consultas
reactivas; y, drift_flutter como paquete para facilitar la integración de Drift con Flutter en plataformas nativas y web.

Se eligió esta combinación de tecnologías por su compatibilidad multiplataforma,
soporte para operaciones asíncronas y posibilidad de mantener una misma capa de
persistencia entre diferentes OS.

## Diseño de la base de datos
Para almacenar la información se diseñó una tabla llamada `tareas`, que cuenta con los siguientes campos:

| Campo | Tipo de dato | Descripción |
|---|---|---|
| id | INTEGER PRIMARY KEY | Identificador único de cada tarea |
| titulo | TEXT NOT NULL | Nombre de la tarea |
| completada | INTEGER NOT NULL DEFAULT 0 | Estado: 0 = pendiente, 1 = completada |

El campo "id" es la clave primaria y permite identificar a cada tarea de manera única.

## Compatibilidad y pruebas
La aplicación fue desarrollada con Flutter, SQLite, Drift y drift_flutter, utilizando una misma capa de persistencia para las distintas plataformas.

Para su ejecución en navegadores, se incorporaron los archivos sqlite3.wasm y drift_worker.dart.js en la carpeta web/, junto con la configuración correspondiente de Drift.

## Plataformas verificadas
Se comprobó la persistencia y usabilidad de la aplicación en macOS, Google Chrome, Android 12 (Moto G51 5G) y en iOS 27 (iPhone 16).

Windows y Linux se consideran plataformas previstas por la arquitectura multiplataforma, pero no se realizaron pruebas de ejecución en ellas.

## Pruebas automatizadas
El proyecto incluye tres pruebas ejecutables mediante `flutter test`:

1. Apertura de la interfaz.
2. Inserción y consulta de una tarea en SQLite.
3. Rechazo de títulos vacíos o compuestos únicamente por espacios. 

## Ejecución del proyecto
Para ejecutar el proyecto es necesario tener Flutter previamente instalado.

1. Instalar las dependencias:
   `flutter pub get`

2. Comprobar que el código no tenga problemas:
   `flutter analyze`

3. Ejecutar las pruebas:
   `flutter test`

4. Abrir la aplicación en Chrome en un puerto específico o en macOS:
   `flutter run -d chrome --web-port 8080`
   `flutter run -d macos`

NOTA
Para ejecutar en otro dispositivo, consultar su identificador:
`flutter devices`
`flutter run -d ID_DEL_DISPOSITIVO`
