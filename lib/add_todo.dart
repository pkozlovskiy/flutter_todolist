import 'package:flutter/material.dart';

class AddTodo extends StatefulWidget {
  final onAddNewTodo;
  AddTodo(this.onAddNewTodo, {Key key}) : super(key: key);

  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final _titleController = TextEditingController();

  @override
  void initState() {
    _titleController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.all(12),
            child: TextField(
              controller: _titleController,
              decoration: InputDecoration.collapsed(hintText: 'Add a task'),
            ),
          ),
        ),
        VerticalDivider(),
        Container(
          decoration: BoxDecoration(
            border: BorderDirectional(
              start: BorderSide(
                width: 0.0,
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
          child: FlatButton.icon(
            icon: Icon(
              Icons.add_circle,
              color: _titleController.text.isEmpty ? Theme.of(context).disabledColor : Theme.of(context).accentColor,
            ),
            label: Text("ADD"),
            onPressed: _titleController.text.isEmpty
                ? null
                : () {
                    widget.onAddNewTodo(_titleController.text);
                    _titleController.text = '';
                  },
          ),
        ),
      ],
    );
  }
}
