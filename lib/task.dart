import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  final DateTime id;

  Task({this.id});
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  String _title = 'Task title';
  Icon _trailingArrow = Icon(Icons.expand_more);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(Icons.work),
      title: Text(_title),
      subtitle: Text(widget.id.toString()),
      trailing: _trailingArrow,
      onExpansionChanged:  (expanded) {
        if (expanded) {
          setState(() {
            _trailingArrow = Icon(Icons.expand_less);
          });
        } else {
          setState(() {
            _trailingArrow = Icon(Icons.expand_more);
          });
        }
      },
      children: [
        Text('Expanded'),
      ],
    );
  }
}
