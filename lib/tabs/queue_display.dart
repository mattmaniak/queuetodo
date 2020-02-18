import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:queuetodo/config.dart';
import 'package:queuetodo/task.dart';

class QueueDisplay extends StatefulWidget {
  @override
  _QueueDisplayState createState() => _QueueDisplayState();
}

class _QueueDisplayState extends State<QueueDisplay> {
  static const int _tasksMax = 100;
  Queue<Task> _tasks = Queue();

  void initState() {
    super.initState();
    configRead(_tasksMax, _popTask, _saveTasks).then((tasks) {
      setState(() {
        _tasks = tasks;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Widget _popButton = _queueButton(
      label: 'Pop the first task',
      tooltip: 'Remove the first task from the queue.',
      icon: Icons.delete_forever,
      onPressed: _popTask,
    );

    final Widget _pushButton = _queueButton(
      label: 'Push a task',
      tooltip: 'Add a task to the end of the queue.',
      icon: Icons.add_box,
      onPressed: _pushTask,
    );

    return Column(
      children: [
        _tasks.isNotEmpty ? _popButton : Container(),
        Column(
          children: _tasks.toList(),
        ),
        _tasks.length < _tasksMax ? _pushButton : Container(),
      ],
    );
  }

  Widget _queueButton(
      {@required String tooltip,
      @required String label,
      @required IconData icon,
      @required Function onPressed}) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          icon: Icon(icon),
          tooltip: tooltip,
          label: Text(label),
          onPressed: onPressed,
        ),
      ),
    );
  }

  void _showQueueDialog(
      {@required String title,
      @required String content,
      @required Function onPressed}) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: Theme.of(context).cardTheme.shape,
          backgroundColor: Theme.of(context).primaryColorDark,
          title: Text(title),
          content: Text(content),
          actions: [
            FlatButton(
              child: Text(
                'No',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                ),
              ),
              onPressed: Navigator.of(context).pop,
            ),
            FlatButton(
              child: Text(
                'Yes',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                ),
              ),
              onPressed: () {
                onPressed();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
      barrierDismissible: false,
    );
  }

  void _saveTasks() => configSave(_tasks, _tasksMax);

  void _popTask() {
    void pop() {
      setState(() {
        _tasks.removeFirst();
      });
      _saveTasks();
    }

    if (_tasks.isNotEmpty) {
      _showQueueDialog(
        title: 'Pop?',
        content: 'Already finished the task?',
        onPressed: pop,
      );
    }
  }

  void _pushTask() {
    void push() {
      final now = DateTime.now();
      setState(() {
        _tasks.add(
          Task(
            titleController: TextEditingController(),
            descriptionController: TextEditingController(),
            creationTimestamp: now,
            lastModified: now,
            removeTask: _popTask,
            saveConfig: _saveTasks,
          ),
        );
      });
      _saveTasks();
    }

    if (_tasks.length < _tasksMax) {
      _showQueueDialog(
        title: 'Push?',
        content: 'Is there anything new to do?',
        onPressed: push,
      );
    } // Else: 'Add' button isn't rendered.
  }
}
