import 'package:flutter/material.dart';

import 'task.dart';

class Queue extends StatefulWidget {
  final List<Task> tasks;

  Queue({@required this.tasks});
  _QueueState createState() => _QueueState();
}

class _QueueState extends State<Queue> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: widget.tasks.toList(),
    );
  }
}
