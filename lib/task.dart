import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  final int taskIndex;

  Task({this.taskIndex});
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green,
      child: ListTile(
        leading: Icon(Icons.all_inclusive),
        title: Text(widget.taskIndex.toString()),
      ),
    );
  }
}
