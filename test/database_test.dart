
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gestor_tareas_local/data/app_database.dart';

void main() {
  test('Guardar y consultar una tarea en SQLite', () async {
    final baseDatos = AppDatabase.forTesting(
      NativeDatabase.memory(),
    );

    addTearDown(() => baseDatos.close());

    final id = await baseDatos.agregarTarea('Estudiar Flutter');

    final tareas = await baseDatos.select(baseDatos.tareas).get();

    expect(tareas.length, 1);
    expect(tareas.first.id, id);
    expect(tareas.first.titulo, 'Estudiar Flutter');
    expect(tareas.first.completada, false);
  });
}
