import 'package:flutter/material.dart';
import 'package:flutter_todolist/todo.dart';
import 'package:flutter_todolist/todo_item.dart';

class TodoList extends StatelessWidget {
  final Stream<List<Todo>> _all;
  final _onTodoChanged;

  TodoList(this._all, this._onTodoChanged);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: _all,
        builder: (context, snapshot) {
          return Scrollbar(
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(height: 0.0),
              itemCount: snapshot.hasData ? snapshot.data.length ?? 0 : 0,
              itemBuilder: (contex, index) {
                return TodoItem(snapshot.data[index], _onTodoChanged);
              },
            ),
          );
        },
      ),
    );
  }
}
