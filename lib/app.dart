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
  static const int _tasksMax = 4;
  Queue<Task> _tasks = Queue();
  List<Widget> _tabs;
  int _tabIndex = 0;

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
      ListView(
        children: _tasks.toList(),
      ),
      Usage(),
      About()
    ];
    return SafeArea(
      child: Scaffold(
        body: _tabs[_tabIndex],
        floatingActionButton: _renderFloatingButton,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: BottomAppBar(
          child: BottomNavigationBar(
            // backgroundColor: Theme.of(context).primaryColor,
            // selectedItemColor: Theme.of(context).accentColor,
            // unselectedItemColor: Theme.of(context).iconTheme.color,
            currentIndex: _tabIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.queue),
                title: Text('Queue'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check_box),
                title: Text('Usage'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.description),
                title: Text('About'),
              ),
            ],
            onTap: _switchTab,
          ),
        ),
      ),
    );
  }

  Widget get _renderFloatingButton {
    if (_tabIndex == 0) {
      return FloatingActionButton.extended(
        icon: Icon(Icons.add_box),
        label: Text('Add'),
        tooltip: 'Create a new task',
        onPressed: _createTask,
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
      if (_tasks.length == 1) {
        _tasks.first.isFirstInQueue = true;
      }
    }
  }

  void _saveTasks() => configSave(_tasks);

  void _removeFirstTask() {
    if (_tasks.isNotEmpty) {
      setState(() {
        _tasks.removeFirst();
      });
    }
    setState(() {
      if (_tasks.isNotEmpty) {
        _tasks.first.isFirstInQueue = true;
      }
    });
  }

  void _switchTab(int index) {
    setState(() {
      _tabIndex = index;
    });
  }
}
