import 'package:flutter/material.dart';

class Archive extends StatelessWidget {
  final List<Widget> tasks;

  @override
  Archive({@required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: ListTile(
            title: Text('Your last 10 finished tasks:'),
          ),
        ),
        Column(
          children: tasks ?? [],
        ),
      ],
    );
  }
}
