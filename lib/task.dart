import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  Task({this.creationTime});
  final DateTime creationTime;

  _TaskState createState() => _TaskState(creationTime: this.creationTime);
}

class _TaskState extends State<Task> {
  _TaskState({this.creationTime});
  final DateTime creationTime;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green,
      child: ListTile(
        leading: Icon(Icons.all_inclusive),
        title: Text(creationTime.toString()),
      ),
    );
  }
}