import 'dart:async';
import 'package:moor_flutter/moor_flutter.dart';
part 'todo.g.dart';

@DataClassName('Todo')
class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  BoolColumn get isDone => boolean()();
}

@UseMoor(tables: [Todos])
class Database extends _$Database {
  Database()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'flutter_toolist_db.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;

  Future addTodo(Todo todo) {
    return into(todos).insert(todo);
  }

  Future updateTodo(Todo todo) {
    return update(todos).replace(todo);
  }

  Stream<List<Todo>> watchTodos() {
    return (select(todos)..orderBy([(t) => OrderingTerm(expression: t.title)]))
        .watch();
  }

  Future saveAll(List<Todo> list) {
    return into(todos).insertAll(list, orReplace: true);
  }

  Future loadAll() {
    return (select(todos)..orderBy([(t) => OrderingTerm(expression: t.title)]))
        .get();
  }
}
