import 'package:flutter/material.dart';
import 'task.dart';

class Layout extends StatefulWidget {
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  final int _tasksMax = 16;
  int _tasksAmount = 0;
  List<Widget> _tasks = [];

  void _addTask() {
    setState(() {
      if(_tasks.length < _tasksMax) {
        _tasks.add(Task(taskIndex: _tasksAmount));
      }
      _tasksAmount =_tasks.length;
    });
  }

  void _deleteTask() {
    setState(() {
      if(_tasks.isNotEmpty) {
        _tasks.removeAt(0);
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
      body: ListView(
        scrollDirection: Axis.vertical,
        children: _tasks.toList(),
      ),
    );
  }
}
