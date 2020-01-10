import 'package:flutter/material.dart';
import 'task.dart';

class Layout extends StatefulWidget {
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  static const int _tasksMax = 16;
  List<Task> _tasks = [];

  void _addTask() {
    if(_tasks.length < _tasksMax) {
      setState(() {
        _tasks.add(Task(taskIndex: _tasks.length + 1));
      });
    }
  }

  void _deleteTask() {
    if(_tasks.isNotEmpty) {
      try {
        setState(() {
          _tasks.removeAt(0);
        });
      } on UnsupportedError {
        // Fixed size list.
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: ListView(
        scrollDirection: Axis.vertical,
        children: _tasks.toList(),
      ),
    );
  }
}
