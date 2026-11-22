
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
      : super(driftDatabase(name: 'gestor_tareas_local'));
    
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

  @override
  int get schemaVersion => 1;
}
