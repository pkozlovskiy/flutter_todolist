import 'package:flutter/material.dart';
import 'package:flutter_todolist/add_todo.dart';
import 'package:flutter_todolist/search_todo.dart';
import 'package:flutter_todolist/todo.dart';
import 'package:flutter_todolist/todo_list.dart';
import 'package:flutter_todolist/todo_repository.dart';

class HomeScreen extends StatelessWidget {
  final TodoRepository _repository;

  HomeScreen(this._repository);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Divider(height: 0.0),
            SearchTodo(_onSearchTodo),
            Divider(height: 0.0),
            AddTodo(_onAddNewTodo),
            Divider(height: 0.0),
            Expanded(
              child: TodoList(_repository.getAll(), _onTodoChanged),
            ),
          ],
        ),
      ),
    );
  }

  void _onTodoChanged(Todo todo) {
    _repository.updateTodo(todo);
  }

  void _onAddNewTodo(String title) {
    _repository.addTodo(title);
  }

  void _onSearchTodo(String substr) {
    _repository.setSearchStr(substr);
  }
}
