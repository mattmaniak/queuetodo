import 'dart:collection';

import 'package:flutter/material.dart';

import 'package:queuetodo/config.dart';
import 'package:queuetodo/localization.dart';
import 'package:queuetodo/task.dart';

/// Place for all tasks to queue.
class QueueDisplay extends StatefulWidget {
  @override
  _QueueDisplayState createState() => _QueueDisplayState();
}

/// Task queue handler.
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
      label: Localization.of(context).words['queue']['pop_task'],
      icon: Icons.delete_forever,
      onPressed: _popTask,
    );

    final Widget _pushButton = _queueButton(
      label: Localization.of(context).words['queue']['push_task'],
      icon: Icons.add_box,
      onPressed: _pushTask,
    );

    return ListView(
      children: [
        _tasks.isNotEmpty ? _popButton : Container(),
        Column(
          children: _tasks.toList(),
        ),
        _tasks.length < _tasksMax ? _pushButton : Container(),
      ],
    );
  }

  /// The wide button with the same with as tasks.
  Widget _queueButton(
      {@required IconData icon,
      @required String label,
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
          label: Text(label),
          onPressed: onPressed,
        ),
      ),
    );
  }

  /// Small confirmation window.
  ///
  /// Display before each push/pop action.
  void _showQueueDialog(
      {@required String title, @required Function onPressed}) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColor,
          shape: Theme.of(context).cardTheme.shape,
          title: Text(title),
          actions: [
            FlatButton(
              child: Text(
                Localization.of(context).words['queue']['cancelation'],
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                ),
              ),
              onPressed: Navigator.of(context).pop,
            ),
            FlatButton(
              child: Text(
                Localization.of(context).words['queue']['confirmation'],
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

  void _saveTasks() => configSave(_tasks);

  /// Remove the first task from the queue.
  void _popTask() {
    void pop() {
      setState(() {
        _tasks.removeFirst();
      });
      _saveTasks();
    }

    if (_tasks.isNotEmpty) {
      _showQueueDialog(
        title: Localization.of(context).words['queue']['pop_question'],
        onPressed: pop,
      );
    }
  }

  /// Add a task to the end of the queue.
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
        title: Localization.of(context).words['queue']['push_question'],
        onPressed: push,
      );
    } // Else: 'Add' button isn't rendered.
  }
}
