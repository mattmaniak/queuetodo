import 'package:flutter/material.dart';

import 'task.dart';

class Queue extends StatefulWidget {
  _QueueState createState() => _QueueState();
}

class _QueueState extends State<Queue> {
  static const int _tasksMax = 16;
  List<Task> _tasks = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: _tasks.toList(),
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
