import 'dart:collection';

import 'package:flutter/material.dart';

import 'about.dart';
import 'config.dart';
import 'error.dart';
import 'usage.dart';
import 'task.dart';

enum _AppTabs { usage, queue, about }

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  static const int _tasksMax = 100;
  Queue<Task> _tasks = Queue();
  int _tabIndex = 1;
  BuildContext _scaffoldContext;

  _AppState() {
    configRead(_tasksMax, _popTask, _saveTasks).then((tasks) {
      setState(() {
        _tasks = tasks;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<List<Widget>> tabs = [
      [Usage()],
      [
        _displayQueuePopperButton,
        Column(
          children: _tasks.toList(),
        ),
        _displayQueuePusherButton,
      ],
      [About()],
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: Builder(
        builder: (BuildContext context) {
          _scaffoldContext = context;
          return ListView(
            children: tabs[_tabIndex],
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
              icon: Icon(Icons.check_box),
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
      ),
    );
  }

  Widget get _displayQueuePopperButton {
    if ((_tabIndex == _AppTabs.queue.index) && _tasks.isNotEmpty) {
      return Padding(
        padding: EdgeInsets.all(4.0),
        child: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          icon: Icon(Icons.delete_forever),
          tooltip: 'Remove the first task from the queue.',
          label: Text('Pop the first task'),
          onPressed: _popTask,
        ),
      );
    }
    return Container();
  }

  Widget get _displayQueuePusherButton {
    if (_tabIndex == _AppTabs.queue.index) {
      return Padding(
        padding: EdgeInsets.all(4.0),
        child: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          icon: Icon(Icons.add_box),
          tooltip: 'Add a task to the end of the queue.',
          label: Text('Push a task'),
          onPressed: _pushTask,
        ),
      );
    }
    return Container();
  }

  void _pushTask() {
    if (_tasks.length < _tasksMax) {
      setState(() {
        _tasks.addLast(
          Task(
            creationTimestamp: DateTime.now(),
            removeTask: _popTask,
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

  void _popTask() {
    if (_tasks.isNotEmpty) {
      setState(() {
        _tasks.removeFirst();
      });
      _saveTasks();
    }
  }

  void _switchTab(int index) {
    setState(() {
      _tabIndex = index;
    });
  }
}
