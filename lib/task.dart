import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  final int maxDescriptionLength = 300;
  final int maxTitleLength = 30;
  final DateTime idWhenCreated;
  final Function removeTask;
  DateTime lastModified;
  bool isFirstInQueue;

  Task(
      {@required this.idWhenCreated,
      @required this.isFirstInQueue,
      @required this.removeTask});

  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
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
    widget.lastModified = widget.idWhenCreated;

    _titleController.addListener(() {
      setState(() {
        _title = _titleController.text;
        widget.lastModified = DateTime.now();
      });
    });
    _descriptionController.addListener(() {
      setState(() {
        _description = _descriptionController.text;
        widget.lastModified = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: _renderTitle,
        subtitle: Text('Created ${_shortenDateTime(widget.idWhenCreated)}'),
        trailing: _trailingArrow,
        initiallyExpanded: true,
        onExpansionChanged: _changeTileExpansion,
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 40.0,
                child: Text(
                  'Last modified ${widget.lastModified}',
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
                  maxLength: widget.maxDescriptionLength,
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
          maxLength: widget.maxTitleLength,
          controller: _titleController,
        ),
      );
    } else {
      return Text(_title);
    }
  }

  Widget get _renderRemoveButton {
    if (widget.isFirstInQueue) {
      return FlatButton(
        child: Text('Finish task'),
        onPressed: widget.removeTask,
      );
    }
    return Padding(
      padding: EdgeInsets.only(
        bottom: 16.0,
      ),
      child: Container(
        width: 0.0,
        height: 0.0,
      ),
    );
  }

  String _shortenDateTime(DateTime date) {
    if (date != null) {
      // Seconds and miliseconds are removed.
      return '${date.year}-${date.month}-${date.day} '
          '${date.hour + 1}:${date.minute}';
    }
    return '1970-01-01 00:00';
  }
}
