import 'package:flutter/material.dart';
import 'task.dart';

class Layout extends StatefulWidget {
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  final int _tasksMin = 1;
  final int _tasksMax = 8;
  int _tasksAmount = 1;
  List<Task> tasks;

  void _addTask() {
    setState(() {
      _tasksAmount++;

      if(_tasksAmount > _tasksMax) {
        _tasksAmount = _tasksMax;
      } else {
        tasks.add(Task());
      }
    });
  }

  void _deleteTask() {
    setState(() {
      _tasksAmount--;

      if(_tasksAmount < _tasksMin) {
        _tasksAmount = _tasksMin;
      } else {
        tasks.remove(Task());
      }
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
        children: tasks,
      )
    );
  }
}
