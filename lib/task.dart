import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  final int maxDescriptionLength = 300;
  final int maxTitleLength = 30;
  final DateTime creationTimeStamp;
  final Function removeTask;
  final Function saveConfig;
  _TaskState state;
  DateTime lastModified;
  String description = '';
  String title = '';
  bool isFirstInQueue = false;

  Task(
      {@required this.creationTimeStamp,
      @required this.lastModified,
      @required this.removeTask,
      @required this.saveConfig,
      this.description,
      this.title,
      this.isFirstInQueue: false});

  @override
  _TaskState createState() {
    state = _TaskState();
    return state;
  }
}

class _TaskState extends State<Task> {
  final _descriptionController = TextEditingController();
  final _titleController = TextEditingController();
  bool _expanded = true;

  @override
  void initState() {
    super.initState();
    widget.lastModified = widget.creationTimeStamp;

    _titleController.addListener(() {
      if (mounted) {
        setState(() {
          widget.title = _titleController.text;
          widget.lastModified = DateTime.now();
        });
      }
    });
    _descriptionController.addListener(() {
      if (mounted) {
        setState(() {
          widget.description = _descriptionController.text;
          widget.lastModified = DateTime.now();
        });
      }
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
    widget.saveConfig();

    return Card(
      child: ExpansionTile(
        title: _renderTitle,
        subtitle: Text('Created ${_shortenDateTime(widget.creationTimeStamp)}'),
        trailing: _renderTrailingArrow,
        initiallyExpanded: _expanded,
        onExpansionChanged: _changeTileExpansion,
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 40.0,
                child: Text(
                  'Last modified ${_shortenDateTime(widget.lastModified)}',
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

  void collapse() {
    setState(() {
      _expanded = false;
    });
  }

  Widget get _renderTrailingArrow {
    if (_expanded) {
      return Icon(Icons.expand_less);
    } else {
      return Icon(Icons.expand_more);
    }
  }

  void _changeTileExpansion(bool expanded) {
    _expanded = expanded;
    if (mounted && _expanded) {
      setState(() {
        _descriptionController.text = widget.description;
        _titleController.text = widget.title;
      });
    }
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
      return Text(widget.title);
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
          '${date.hour}:${date.minute}';
    }
    return '1970-01-01 00:00';
  }
}
