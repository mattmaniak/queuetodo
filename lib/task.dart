import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Column(
        children: <Widget>[
          Text(
            'Title',
            textScaleFactor: 1.5,
          ),
          Text('Task description.'),
        ],
      ),
    );
  }
}