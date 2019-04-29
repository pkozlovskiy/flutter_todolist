import 'dart:async';

import 'package:flutter_todolist/todo.dart';
import 'package:logging/logging.dart';

abstract class TodoRepository {
  Stream<List<Todo>> getAll();
  addTodo(String title);
  removeTodo(Todo todo);
  updateTodo(Todo newTodo);
  setSearchStr(String str);
  dispose();
}

class RepositoryImpl extends TodoRepository {
  final _db = Database();
  static final _log = Logger('RepositoryImpl');
  List<Todo> _todos = [];
  String _searchStr = '';
  var _controller = StreamController<List<Todo>>();

  RepositoryImpl() {
    _db.loadAll().then((list) {
      _log.info('On load todos $list');

      _todos.addAll(list);
      _syncList(save: false);
    });
  }

  @override
  addTodo(String title) {
    _log.info('On add todo with title = $title');
    var todo = Todo(title: title, isDone: false);
    _db.addTodo(todo).then((id) {
      _todos.add(todo.copyWith(id: id));
      _syncList();
    });
  }

  @override
  removeTodo(Todo todo) {
    _log.info('On remove todo = $todo');
    //TODO remove from DB
    _todos.remove(todo);
    _syncList();
  }

  @override
  Stream<List<Todo>> getAll() {
    return _controller.stream;
  }

  @override
  updateTodo(Todo newTodo) {
    _log.info('On change todo = $newTodo');
    _db.updateTodo(newTodo).then((cnt) {
      var index = _todos.indexWhere((todo) => todo.id == newTodo.id);
      _todos[index] = newTodo;
      _syncList();
    });
  }

  _syncList({save = true}) {
    _log.info('Sync list');
    var list = _todos
        .where((todo) => _searchStr.isEmpty
            ? true
            : todo.title.toLowerCase().trim().contains(_searchStr))
        .toList();
    list.sort((a, b) {
      if (a.isDone != b.isDone) {
        return a.isDone ? 1 : -1;
      }
      return a.title.compareTo(b.title);
    });
    _log.info(list);
    _controller.sink.add(list);
  }

  @override
  setSearchStr(String str) {
    _log.info('On search todo with title contains: $str');
    var trimStr = str.toLowerCase().trim();
    if (_searchStr != trimStr) {
      _searchStr = trimStr;
      _syncList(save: false);
    }
  }

  @override
  dispose() {
    _log.info('dispose');
    _controller.close();
  }
}
