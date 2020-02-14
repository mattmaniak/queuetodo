import 'package:flutter/material.dart';

class Archive extends StatelessWidget {
  final int tasksMax;
  final List<Widget> tasks;

  @override
  Archive({@required this.tasksMax, @required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: Text('Your $tasksMax recently finished tasks'),
        ),
        Column(
          children: tasks ?? [],
        ),
      ],
    );
  }
}
