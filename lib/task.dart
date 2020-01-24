import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  final DateTime creationId;
  final Function removeTask;

  Task({@required this.creationId, @required this.removeTask});

  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  static const int _maxDescriptionLength = 300;
  static const int _maxTitleLength = 30;
  final _descriptionController = TextEditingController();
  final _titleController = TextEditingController();
  String _description = '';
  String _title = '';
  bool _expanded = true;
  Icon _trailingArrow = Icon(Icons.expand_less);
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
    return Card(
      child: ExpansionTile(
        title: _renderTitle,
        subtitle: Text('Created ${widget.creationId}'),
        trailing: _trailingArrow,
        initiallyExpanded: true,
        onExpansionChanged: _changeTileExpansion,
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 40.0,
                child: Text(
                  'Last modified $_lastModified',
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Description',
                    isDense: true,
                    counterText: '',
                  ),
                  maxLines: null,
                  maxLength: _maxDescriptionLength,
                  keyboardType: TextInputType.text,
                  controller: _descriptionController,
                ),
              ),
              _renderRemoveButton,
            ],
          ),
        ],
      ),
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
    _expanded = expanded;
  }

  Widget get _renderTitle {
    if (_expanded) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: 8.0,
        ),
        child: TextField(
          decoration: InputDecoration(
            isDense: true,
            hintText: 'Title',
            counterText: '',
          ),
          maxLength: _maxTitleLength,
          controller: _titleController,
        ),
      );
    } else {
      return Text(_title);
    }
  }

  Widget get _renderRemoveButton {
    return FlatButton(
      child: Text('Finish task'),
      onPressed: widget.removeTask,
    );
  }

  String _convertToIsoDate(DateTime date) {
    if (date != null) {
      return '${date.year}-${date.month}-${date.day}';
    }
    return '1970-01-01';
  }
}
