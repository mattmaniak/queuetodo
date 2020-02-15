import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'error.dart';

class Task extends StatefulWidget {
  final descriptionController;
  final titleController;
  final int maxDescriptionLength = 1000;
  final int maxTitleLength = 100;

  final DateTime creationTimestamp;
  final DateTime lastModified;
  final Function removeTask;
  final Function saveConfig;

  Task(
      {@required this.titleController,
      @required this.descriptionController,
      @required this.creationTimestamp,
      @required this.lastModified,
      @required this.removeTask,
      @required this.saveConfig});

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  DateTime _lastModified;
  String _description;
  String _title;

  @override
  void initState() {
    super.initState();

    _lastModified = widget.lastModified;
    _description = widget.descriptionController.text;
    _title = widget.titleController.text;

    widget
      ..descriptionController.addListener(() {
        setState(() {
          _description = widget.descriptionController.text;
          _lastModified = DateTime.now();
        });
        if (_description.length == widget.maxDescriptionLength) {
          showErrorSnackBar(context,
              'Description length limit is ${widget.maxDescriptionLength}.');
        }
      })
      ..titleController.addListener(() {
        setState(() {
          _title = widget.titleController.text;
          _lastModified = DateTime.now();
        });
        if (_title.length == widget.maxTitleLength) {
          showErrorSnackBar(
              context, 'Title length limit is ${widget.maxTitleLength}.');
        }
      })
      ..descriptionController.text = _description
      ..titleController.text = _title;
  }

  @override
  Widget build(BuildContext context) {
    widget.saveConfig();

    return Card(
      child: ExpansionTile(
        title: _textField(
          hintText: 'Title',
          maxLength: widget.maxTitleLength,
          controller: widget.titleController,
        ),
        subtitle: Text(
          'Created ${_formatDate(widget.creationTimestamp)}.',
          style: TextStyle(
            color: Theme.of(context).textTheme.subtitle.color,
          ),
        ),
        initiallyExpanded: false,
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 40.0,
                child: Text(
                  'Last modified ${_formatDate(_lastModified)}.',
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 4.0,
                ),
                child: _textField(
                  hintText: 'Description',
                  maxLength: widget.maxDescriptionLength,
                  controller: widget.descriptionController,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _textField(
      {@required String hintText,
      @required int maxLength,
      @required TextEditingController controller}) {
    return TextField(
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        counterStyle: TextStyle(
          height: 0.5,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
      controller: controller,
      keyboardType:
          hintText == 'Title' ? TextInputType.text : TextInputType.multiline,
      minLines: 1,
      maxLines: maxLength,
      maxLength: maxLength,
    );
  }

  String _formatDate(DateTime date) => DateFormat('yyyy-MM-dd HH:mm:ss')
      .format(date ?? DateTime.fromMillisecondsSinceEpoch(0));
}
