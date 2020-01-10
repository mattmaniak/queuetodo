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
      drawer: Drawer(
        child: Container(
          color: Colors.deepPurple[100],
          child: ListView(
            children: [
              DrawerHeader(
                child: Text('Drawer'),
              ),
              ListTile(
                title: Text('Option'),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            tooltip: 'Add task',
            onPressed: _addTask,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            tooltip: 'Delete task',
            onPressed: _deleteTask,
          ),
        ],
        title: Text('Pending tasks: ${_tasks.length}'),
      ),
      body: Container(
        color: Colors.deepPurple[100],
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
    }
  }

  void _deleteTask() {
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
