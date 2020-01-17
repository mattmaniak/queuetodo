import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  final DateTime creationId;
  final Function removeTask;

  Task({@required this.creationId, @required this.removeTask});
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  final _descriptionController = TextEditingController();
  final _titleController = TextEditingController();
  String _description = '';
  String _title = '';
  Icon _trailingArrow = Icon(Icons.expand_less);
  DateTime _deadline;
  DateTime _lastModified;

  @override
  void initState() {
    super.initState();
    _lastModified = widget.creationId;
    _deadline = widget.creationId;

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
      title: Text('Title: $_title'),
      subtitle: Text('Deadline: ${_convertToIsoDate(_deadline)}'),
      trailing: _trailingArrow,
      initiallyExpanded: true,
      onExpansionChanged: _changeTileExpansion,
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                maxLength: 32,
                autocorrect: false,
                enableSuggestions: false,
                controller: _titleController,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: null,
                maxLength: 256,
                autocorrect: false,
                keyboardType: TextInputType.text,
                enableSuggestions: false,
                controller: _descriptionController,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: ButtonBar(
                alignment: MainAxisAlignment.start,
                children: [
                  FlatButton(
                    // color: Theme.of(context).buttonColor,
                    child: Text(
                      'Change deadline',
                      style: TextStyle(
                        // color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                    onPressed: _setDeadline,
                  ),
                  FlatButton(
                    // color: Theme.of(context).buttonColor,
                    child: Text(
                      'Remove',
                      style: TextStyle(
                        // color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                    onPressed: widget.removeTask,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 20.0,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _changeTileExpansion(bool expanded) {
    setState(() {
      if (expanded) {
        _descriptionController.text = _description;
        _titleController.text = _title;
        _trailingArrow = Icon(Icons.expand_less);
      } else {
        _trailingArrow = Icon(Icons.expand_more);
      }
    });
  }

  void _setDeadline() {
    showDatePicker(
            context: context,
            firstDate: DateTime.now(),
            lastDate: DateTime(2038),
            initialDate: DateTime.now())
        .then((date) {
      setState(() {
        if (date != null) {
          _deadline = date;
        } else {
          _deadline = widget.creationId;
        }
      });
    });
  }

  String _convertToIsoDate(DateTime date) {
    if (date != null) {
      return '${date.year}-${date.month}-${date.day}';
    }
    return '1970-01-01';
  }
}
