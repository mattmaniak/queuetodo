import 'package:flutter/material.dart';

import 'task.dart';

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  static const int _tasksMax = 16;
  List<Task> _tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            color: Colors.black,
            icon: Icon(Icons.add),
            tooltip: 'Create task',
            onPressed: _addTask,
          ),
          IconButton(
            color: Colors.black,
            icon: Icon(Icons.remove),
            tooltip: 'Remove task',
            onPressed: _removeTask,
          ),
        ],
        title: Text(
          'Pending tasks: ${_tasks.length}',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        // color: Colors.yellow[200],
        child: ListView(
          children: _tasks.toList(),
        ),
      ),
    );
  }

  void _addTask() {
    if (_tasks.length < _tasksMax) {
      try {
        setState(() {
          _tasks.add(Task(id: DateTime.now()));
        });
      } on UnsupportedError {
        // Fixed size list.
      }
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => EditTask(),
      //   ),
      // );
    }
  }

  void _removeTask() {
    if (_tasks.isNotEmpty) {
      try {
        setState(() {
          _tasks.remove(_tasks.first);
        });
      } on UnsupportedError {
        // Fixed size list.
      }
    }
  }
}
