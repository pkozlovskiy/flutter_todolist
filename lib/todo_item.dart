import 'package:flutter/material.dart';
import 'package:flutter_todolist/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo _todo;
  final _onTodoChanged;

  const TodoItem(this._todo, this._onTodoChanged);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _onTodoChanged(
          _todo.copyWith(isDone: !_todo.isDone),
        );
      },
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      _todo.title,
                      style: TextStyle(
                        decoration: _todo.isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12),
                  child: Icon(
                    _todo.isDone
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
