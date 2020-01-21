import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  final DateTime creationId;
  final Function removeTask;
  int index;

  Task(
      {@required this.creationId,
      @required this.index,
      @required this.removeTask});

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
    return Card(
      child: ExpansionTile(
        title: _renderTitle,
        subtitle: Text('Deadline: ${_convertToIsoDate(_deadline)} ${widget.index}'),
        trailing: _trailingArrow,
        initiallyExpanded: true,
        onExpansionChanged: _changeTileExpansion,
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 4.0,
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 40.0,
                  child: Container(
                    child: Text(
                      'Last modified: ${_convertToIsoDate(_lastModified)}',
                      textAlign: TextAlign.left,
                    ),
                  ),
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
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  enableSuggestions: false,
                  controller: _descriptionController,
                ),
              ),
              ButtonBar(
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
                  _renderRemoveButton(),
                ],
              ),
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
          autocorrect: false,
          enableSuggestions: false,
          controller: _titleController,
        ),
      );
    } else {
      return Text('Title: $_title');
    }
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

  Widget _renderRemoveButton() {
    Color textColor;

    if (widget.index == 0) {
      textColor = Colors.green;
    } else {
      textColor = Colors.red;
    }
    return FlatButton(
      child: Text(
        'Remove',
        style: TextStyle(
          color: textColor,
        ),
      ),
      onPressed: () => widget.removeTask(widget.index),
    );
  }

  String _convertToIsoDate(DateTime date) {
    if (date != null) {
      return '${date.year}-${date.month}-${date.day}';
    }
    return '1970-01-01';
  }
}
