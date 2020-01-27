import 'dart:collection';

import 'package:flutter/material.dart';

import 'task.dart';

class TasksQueue extends StatelessWidget {
  final Queue<Task> tasks;

  const TasksQueue({@required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: tasks.toList(),
    );
  }
}
