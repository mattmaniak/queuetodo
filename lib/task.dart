import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'error.dart';

class Task extends StatefulWidget {
  final int maxDescriptionLength = 1000;
  final int maxTitleLength = 100;
  final descriptionController = TextEditingController();
  final titleController = TextEditingController();

  final DateTime creationTimestamp;
  final Function removeTask;
  final Function saveConfig;
  DateTime lastModified = DateTime.now();
  String description = '';
  String title = '';

  Task(
      {@required this.creationTimestamp,
      @required this.removeTask,
      @required this.saveConfig,
      this.description,
      this.title,
      this.lastModified});

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  void initState() {
    super.initState();
    widget
      ..lastModified = widget?.creationTimestamp ?? DateTime.now()
      ..titleController.addListener(() {
        setState(() {
          widget?.title = widget?.titleController?.text ?? '';
        });
        if (widget?.title?.length == widget?.maxTitleLength) {
          showErrorSnackBar(
              context, 'Title length limit is ${widget?.maxTitleLength}.');
        }
      })
      ..descriptionController.addListener(() {
        setState(() {
          widget?.description = widget?.descriptionController?.text ?? '';
        });
        if (widget?.description?.length == widget?.maxDescriptionLength) {
          showErrorSnackBar(context,
              'Description length limit is ${widget?.maxDescriptionLength}.');
        }
      })
      ..descriptionController.text = widget?.description ?? ''
      ..titleController.text = widget?.title ?? '';
  }

  @override
  Widget build(BuildContext context) {
    widget?.saveConfig();

    return Card(
      child: ExpansionTile(
        title: Padding(
          padding: EdgeInsets.only(
            bottom: 8.0,
          ),
          child: _textField(
              'Title', widget?.maxTitleLength, widget?.titleController),
        ),
        subtitle: Text(
          'Created ' + _formatDate(widget?.creationTimestamp),
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
                  'Last modified ' + _formatDate(widget?.lastModified),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 8.0,
                ),
                child: _textField('Description', widget?.maxDescriptionLength,
                    widget?.descriptionController),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _textField(String text, int length, TextEditingController control) {
    return TextField(
      decoration: InputDecoration(
        hintText: text,
        isDense: true,
        counterText: '',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
      maxLines: null,
      maxLength: length ?? TextField.noMaxLength,
      keyboardType: TextInputType.text,
      controller: control,
    );
  }

  String _formatDate(DateTime date) {
    date = date ?? DateTime.fromMillisecondsSinceEpoch(0); // 1970-01-01...
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
  }
}
