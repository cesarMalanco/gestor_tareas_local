
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class Tareas extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get titulo => text()();

  BoolColumn get completada =>
      boolean().withDefault(const Constant(false))();
}

@DriftDatabase(tables: [Tareas])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
    : super(
        driftDatabase(
          name: 'gestor_tareas_local',
          web: DriftWebOptions(
            sqlite3Wasm: Uri.parse('sqlite3.wasm'),
            driftWorker: Uri.parse('drift_worker.dart.js'),
          ),
        ),
      );
    
  AppDatabase.forTesting(super.executor);
  
  Future<int> agregarTarea(String titulo) async {
    final tituloLimpio = titulo.trim();

    if (tituloLimpio.isEmpty) {
      throw ArgumentError('El título no puede estar vacío');
    }

    return await into(tareas).insert(
      TareasCompanion.insert(titulo: tituloLimpio),
    );
  }

  // NOTA: Es lo mismo que "SELECT * FROM tareas;"
  Stream<List<Tarea>> observarTareas() {
    return select(tareas).watch();
  }

  // NOTA: Es lo mismo que "UPDATE tareas SET completada = 1 WHERE id = x"
  Future<int> actualizarEstado(int id, bool completada) {
    return (update(tareas)..where((t) => t.id.equals(id))).write(
      TareasCompanion(
        completada: Value(completada),
      ),
    );
  }

  Future<int> editarTitulo(int id, String titulo) {
    final tituloLimpio = titulo.trim();

    if (tituloLimpio.isEmpty) {
      throw ArgumentError('El título no puede estar vacío');
    }

    return (update(tareas)..where((t) => t.id.equals(id))).write(
      TareasCompanion(
        titulo: Value(tituloLimpio),
      ),
    );
  }

  // NOTA: Es lo mismo que "DELETE FROM tareas WHERE id = x;"
  Future<int> eliminarTarea(int id) {
    return (delete(tareas)..where((t) => t.id.equals(id))).go();
  }

  @override
  int get schemaVersion => 1;
}
