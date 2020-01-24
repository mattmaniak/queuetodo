import 'dart:collection';

import 'package:flutter/material.dart';

import 'task.dart';

// class TasksQueue extends StatefulWidget {
//   final Queue<Task> tasks;

//   TasksQueue({@required this.tasks});
//   _TasksQueueState createState() => _TasksQueueState();
// }

class TasksQueue extends StatelessWidget {
  final Queue<Task> tasks;

  TasksQueue({@required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: tasks.toList(),
    );
  }
}
