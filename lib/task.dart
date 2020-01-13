import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  final DateTime creationId;

  Task({this.creationId});
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  Icon _trailingArrow = Icon(Icons.expand_more);
  String _title = 'Task title';
  String _description = 'Description';
  DateTime _lastModified;

  @override
  void initState() {
    super.initState();
    _lastModified = widget.creationId;

    _titleController.addListener(() {
      setState(() {
        _title = _titleController.text;
        _lastModified = DateTime.now();
      });
    });

    _descriptionController.addListener(() {
      setState(() {
        _description = _descriptionController.text;
        _lastModified = DateTime.now();
      });
    });

  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: Icon(Icons.work),
      title: Text(_title),
      subtitle: Text(widget.creationId.toString()),
      trailing: _trailingArrow,
      onExpansionChanged: (expanded) {
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
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Text(_description),
        ),
        Form(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Title'
                  ),
                  // initialValue: _title,
                  autocorrect: false,
                  maxLength: 32,
                  controller: _titleController,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Description'
                  ),
                  // initialValue: _title,
                  autocorrect: false,
                  maxLength: 256,
                  controller: _descriptionController,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 16.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
