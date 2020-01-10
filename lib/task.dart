import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  final DateTime id;

  Task({this.id});
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepPurple[200],
      child: ListTile(
        leading: Icon(Icons.all_inclusive),
        title: Text(widget.id.toString()),
      ),
    );
  }
}
