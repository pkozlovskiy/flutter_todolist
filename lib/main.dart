import 'package:flutter/material.dart';
import 'package:flutter_todolist/home_screen.dart';
import 'package:flutter_todolist/todo_repository.dart';
import 'package:logging/logging.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  runApp(TodoApp(RepositoryImpl()));
}

class TodoApp extends StatefulWidget {
  final TodoRepository _repository;
  TodoApp(this._repository, {Key key}) : super(key: key);

  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        accentColor: Colors.blueAccent,
        dividerColor: Colors.black,
      ),
      home: HomeScreen(widget._repository),
    );
  }

  @override
  void dispose() {
    widget._repository.dispose();
    super.dispose();
  }
}
