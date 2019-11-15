import 'package:flutter/material.dart';
import 'task.dart';
import 'dart:collection' as collection;

class Layout extends StatefulWidget {
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  final int _tasksMin = 0;
  final int _tasksMax = 8;
  int _tasksAmount = 0;
  collection.Queue<Task> _tasks = collection.Queue();

  void _addTask() {
    setState(() {
      if(_tasks.length < _tasksMax) {
        _tasks.add(Task(creationTime: DateTime.now()));
      }
      _tasksAmount =_tasks.length;
    });
  }

  void _deleteTask() {
    setState(() {
      if((_tasks.length > _tasksMin) && (_tasks.isNotEmpty)) {
        _tasks.removeFirst();
      }
      _tasksAmount =_tasks.length;
    });
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
        title: Text('Pending tasks: $_tasksAmount'),
      ),
      body: Column(
        children: _tasks.toList(), // ListView doesn't work.
      ),
    );
  }
}
