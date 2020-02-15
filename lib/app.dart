import 'dart:collection';

import 'package:flutter/material.dart';

import 'about.dart';
import 'config.dart';
import 'usage.dart';
import 'task.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  static const int _tasksMax = 100;

  int _tabIndex = 1;
  Queue<Task> _tasks = Queue();

  _AppState() {
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

    final List<List<Widget>> tabs = [
      [Usage()],
      [
        _tasks.isNotEmpty ? _popButton : Container(),
        Column(
          children: _tasks.toList(),
        ),
        _tasks.length < _tasksMax ? _pushButton : Container(),
      ],
      [About()],
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: ListView(
        children: tabs[_tabIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Theme.of(context).iconTheme.color,
        type: BottomNavigationBarType.shifting,
        currentIndex: _tabIndex,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColorDark,
            icon: Icon(Icons.help_outline),
            title: Text('Usage'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColorDark,
            icon: Icon(Icons.queue),
            title: Text('Queue'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColorDark,
            icon: Icon(Icons.description),
            title: Text('About'),
          ),
        ],
        onTap: _switchTab,
      ),
    );
  }

  Widget _queueButton(
      {@required String tooltip,
      @required String label,
      @required IconData icon,
      @required Function onPressed}) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        icon: Icon(icon),
        tooltip: tooltip,
        label: Text(label),
        onPressed: onPressed,
      ),
    );
  }

  void _showQueueDialog(
      {@required String title,
      @required String content,
      @required Function onYes}) {
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
                onYes();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
      barrierDismissible: false,
    );
  }

  void _pushTask() {
    void push() {
      final now = DateTime.now();
      setState(() {
        _tasks.add(
          Task(
            // title: '',
            // description: '',
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
        onYes: push,
      );
    } // Else: 'Add' button isn't rendered.
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
        onYes: pop,
      );
    }
  }

  void _switchTab(int index) {
    if (_tabIndex != index) {
      setState(() {
        _tabIndex = index;
        configRead(_tasksMax, _popTask, _saveTasks).then((tasks) {
          _tasks = tasks;
        });
      });
    }
  }
}
