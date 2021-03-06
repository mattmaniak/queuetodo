import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:queuetodo/error.dart';
import 'package:queuetodo/localization.dart';

/// An expandable tile with two text inputs and date info.
class Task extends StatefulWidget {
  final int maxDescriptionLength = 1000;
  final int maxTitleLength = 100;
  final descriptionController;
  final titleController;

  final DateTime creationTimestamp;
  final DateTime lastModified;
  final Function removeTask;
  final Function saveConfig;

  const Task(
      {@required this.titleController,
      @required this.descriptionController,
      @required this.creationTimestamp,
      @required this.lastModified,
      @required this.removeTask,
      @required this.saveConfig});

  @override
  _TaskState createState() => _TaskState();
}

/// Task's current properties holder and it's renderer.
class _TaskState extends State<Task> {
  DateTime _lastModified;
  String _description;
  String _title;

  /// Set default or loaded values and initialize input controllers.
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
          showErrorSnackBar(
              context,
              Localization.of(context).words['task']['description_limit_info'] +
                  ' ${widget.maxDescriptionLength}.');
        }
      })
      ..titleController.addListener(() {
        setState(() {
          _title = widget.titleController.text;
          _lastModified = DateTime.now();
        });
        if (_title.length == widget.maxTitleLength) {
          showErrorSnackBar(
              context,
              Localization.of(context).words['task']['title_limit_info'] +
                  ' ${widget.maxTitleLength}.');
        }
      })
      ..descriptionController.text = _description
      ..titleController.text = _title;
  }

  @override
  Widget build(BuildContext context) {
    /// Render the tile and save config each time it redraws.
    ///
    /// Everytime the widget is redrawn, the config will be saved, e.g. when the
    /// user writes a letter.
    widget.saveConfig();

    return Card(
      child: ExpansionTile(
        title: _TaskTextField(
          hintText: Localization.of(context).words['task']['title'],
          maxLength: widget.maxTitleLength,
          controller: widget.titleController,
        ),
        subtitle: Text(
          Localization.of(context).words['task']['created'] +
              ' ' +
              _formatDate(widget.creationTimestamp),
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
                  Localization.of(context).words['task']['last_modified'] +
                      ' ' +
                      _formatDate(_lastModified),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 4.0,
                ),
                child: _TaskTextField(
                  hintText: Localization.of(context).words['task']
                      ['description'],
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

  /// Return and ISO-formatted date.
  String _formatDate(DateTime date) => DateFormat('yyyy-MM-dd HH:mm:ss')
      .format(date ?? DateTime.fromMillisecondsSinceEpoch(0));
}

/// An input for [widget.title] and [widget.description].
class _TaskTextField extends StatelessWidget {
  final int maxLength;
  final String hintText;
  final TextEditingController controller;

  const _TaskTextField({this.maxLength, this.hintText, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        isDense: true,
        hintText: this.hintText,
        counterStyle: TextStyle(
          height: 0.5,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
      controller: this.controller,
      keyboardType:
          this.hintText == Localization.of(context).words['task']['title']
              ? TextInputType.text
              : TextInputType.multiline,
      minLines: 1,
      maxLines: this.maxLength,
      maxLength: this.maxLength,
    );
  }
}
