import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  Task({this.taskIndex});
  final int taskIndex;

  _TaskState createState() => _TaskState(taskIndex: this.taskIndex);
}

class _TaskState extends State<Task> {
  _TaskState({this.taskIndex});
  final int taskIndex;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green,
      child: ListTile(
        leading: Icon(Icons.all_inclusive),
        title: Text(taskIndex.toString()),
      ),
    );
  }
}