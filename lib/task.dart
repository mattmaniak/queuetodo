import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class Task extends StatefulWidget {
  final int maxDescriptionLength = 300;
  final int maxTitleLength = 30;
  final descriptionController = TextEditingController();
  final titleController = TextEditingController();

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
      @required this.removeTask,
      @required this.saveConfig,
      this.description,
      this.title,
      this.lastModified,
      this.isFirstInQueue: false});

  @override
  _TaskState createState() {
    state = _TaskState();
    return state;
  }
}

class _TaskState extends State<Task> {
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    widget
      ..lastModified = widget?.creationTimeStamp ?? DateTime.now()
      ..titleController.addListener(() {
        if (mounted) {
          setState(() {
            widget
              ..title = widget.titleController.text
              ..lastModified = DateTime.now();
          });
        }
      })
      ..descriptionController.addListener(() {
        if (mounted) {
          setState(() {
            widget
              ..description = widget.descriptionController.text
              ..lastModified = DateTime.now();
          });
        }
      })
      ..descriptionController.text = widget?.description ?? ''
      ..titleController.text = widget?.title ?? '';
  }

  @override
  void dispose() {
    if (mounted) {
      // widget
      //   ..descriptionController.dispose()
      //   ..titleController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget?.saveConfig();

    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(
          16.0,
        ),
      )),
      child: ExpansionTile(
        title: Padding(
          padding: EdgeInsets.only(
            bottom: 8.0,
          ),
          child: TextField(
            decoration: InputDecoration(
              isDense: true,
              hintText: 'Title',
              counterText: '',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            maxLength: widget?.maxTitleLength ?? TextField.noMaxLength,
            controller: widget?.titleController,
          ),
        ),
        subtitle: Text(
          'Created ' +
              DateFormat('yyyy-MM-dd HH:mm:ss')
                  .format(widget?.creationTimeStamp),
          style: TextStyle(
            color: Theme.of(context).textTheme.subtitle.color,
          ),
        ),
        trailing: _renderTrailingArrow,
        initiallyExpanded: _expanded,
        onExpansionChanged: _changeTileExpansion,
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 40.0,
                child: Text(
                  'Last modified ' +
                      DateFormat('yyyy-MM-dd HH:mm:ss')
                          .format(widget?.lastModified),
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
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                  maxLines: null,
                  maxLength:
                      widget?.maxDescriptionLength ?? TextField.noMaxLength,
                  keyboardType: TextInputType.text,
                  controller: widget.descriptionController,
                ),
              ),
              _renderRemoveButton,
            ],
          ),
        ],
      ),
    );
  }

  Widget get _renderTrailingArrow {
    if (_expanded) {
      return Icon(
        Icons.expand_less,
        color: Theme.of(context).accentColor,
      );
    }
    return Icon(
      Icons.expand_more,
      color: Theme.of(context).accentColor,
    );
  }

  void _changeTileExpansion(bool expanded) {
    _expanded = expanded;
    if (mounted && _expanded) {
      setState(() {
        widget
          ..descriptionController.text = widget?.description ?? ''
          ..titleController.text = widget?.title ?? '';
      });
    }
  }

  Widget get _renderRemoveButton {
    if (widget?.isFirstInQueue ?? false) {
      return FlatButton(
        color: Theme.of(context).buttonColor,
        child: Text('Finish task'),
        onPressed: widget?.removeTask ?? () {},
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
}
