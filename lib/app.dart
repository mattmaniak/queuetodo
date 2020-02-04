import 'dart:collection';

import 'package:flutter/material.dart';

import 'about.dart';
import 'config.dart';
import 'error.dart';
import 'usage.dart';
import 'task.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  static const int _tasksMax = 100;
  Queue<Task> _tasks = Queue();
  List<List<Widget>> _tabs;
  int _tabIndex = 0;
  BuildContext _scaffoldContext;

  _AppState() {
    configRead(_tasksMax, _removeFirstTask, _saveTasks).then((tasks) {
      setState(() {
        _tasks = tasks;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _tabs = [
      [
        _displayQueuePopperButton,
        Column(
          children: _tasks.toList(),
        ),
        _displayQueuePusherButton,
      ],
      [Usage()],
      [About()],
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: Builder(
        builder: (BuildContext context) {
          _scaffoldContext = context;
          return ListView(
            children: _tabs[_tabIndex],
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: BottomNavigationBar(
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Theme.of(context).iconTheme.color,
          showUnselectedLabels: true,
          currentIndex: _tabIndex,
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColorDark,
              icon: Icon(Icons.queue),
              title: Text('Queue'),
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColorDark,
              icon: Icon(Icons.check_box),
              title: Text('Usage'),
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColorDark,
              icon: Icon(Icons.description),
              title: Text('About'),
            ),
          ],
          onTap: _switchTab,
        ),
      ),
    );
  }

  Widget get _displayQueuePopperButton {
    if (_tabIndex == 0) {
      return Padding(
        padding: EdgeInsets.all(4.0),
        child: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          icon: Icon(Icons.delete_forever),
          tooltip: 'Pop a task from the Queue.',
          label: Text('Remove a task'),
          onPressed: _removeFirstTask,
        ),
      );
    }
    return null;
  }

  Widget get _displayQueuePusherButton {
    if (_tabIndex == 0) {
      return Padding(
        padding: EdgeInsets.all(4.0),
        child: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          icon: Icon(Icons.add_box),
          tooltip: 'Push a task to the Queue.',
          label: Text('Create a task'),
          onPressed: _createTask,
        ),
      );
    }
    return null;
  }

  void _createTask() {
    if (_tasks.length < _tasksMax) {
      setState(() {
        _tasks.addLast(
          Task(
            creationTimeStamp: DateTime.now(),
            removeTask: _removeFirstTask,
            saveConfig: _saveTasks,
          ),
        );
      });
    } else {
      showErrorSnackBar(
          _scaffoldContext, 'Maximum number of tasks is $_tasksMax.');
    }
  }

  void _saveTasks() => configSave(_tasks);

  void _removeFirstTask() {
    if (_tasks.isNotEmpty) {
      setState(() {
        _tasks.removeFirst();
      });
    }
  }

  void _switchTab(int index) {
    setState(() {
      _tabIndex = index;
    });
  }
}
