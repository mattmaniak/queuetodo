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
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            tooltip: 'Create task',
            onPressed: _createTask,
          ),
          IconButton(
            icon: Icon(Icons.remove),
            tooltip: 'Remove task',
            onPressed: _removeTask,
          ),
        ],
        title: Text(
          'Pending tasks: ${_tasks.length}',
        ),
      ),
      body: Container(
        child: ListView(
          children: _tasks.toList(),
        ),
      ),
    );
  }

  void _createTask() {
    if (_tasks.length < _tasksMax) {
      try {
        setState(() {
          _tasks.add(Task(creationId: DateTime.now()));
        });
      } on UnsupportedError {
        // Fixed size list.
      }
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
