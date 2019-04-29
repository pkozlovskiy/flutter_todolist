import 'package:flutter/material.dart';

class SearchTodo extends StatefulWidget {
  final _onSearchTodo;

  SearchTodo(this._onSearchTodo, {Key key}) : super(key: key);

  _SearchTodoState createState() => _SearchTodoState();
}

class _SearchTodoState extends State<SearchTodo> {
  var _searchQuery = TextEditingController();

  @override
  void initState() {
    _searchQuery.addListener(() {
      setState(() {});
      widget._onSearchTodo(_searchQuery.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(12),
              child: TextField(
                controller: _searchQuery,
                decoration: InputDecoration.collapsed(hintText: null),
              ),
            ),
          ),
          IconButton(
            icon: Icon(_searchQuery.text.isEmpty ? Icons.search : Icons.close),
            onPressed: () {
              if (_searchQuery.text.isNotEmpty) {
                _searchQuery.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
