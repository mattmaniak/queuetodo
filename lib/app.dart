import 'dart:collection';

import 'package:flutter/material.dart';

import 'about.dart';
import 'config.dart';
import 'how_to.dart';
import 'task.dart';
import 'tasks_queue.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  static const int _tasksMax = 8;
  Queue<Task> _tasks = Queue();
  List<Widget> _tabs;
  int _tabIndex = 0;

  _AppState() {
    configRead(_removeFirstTask, configSave).then((tasks) {
      setState(() {
        _tasks = tasks;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _tabs = [
      TasksQueue(
        tasks: _tasks,
      ),
      HowTo(),
      About()
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.add_box),
              onPressed: _createTask,
            ),
            IconButton(
              icon: Icon(Icons.done),
              onPressed: _removeFirstTask,
            ),
          ],
        ),
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
                title: Text('How To'),
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
        icon: Icon(Icons.save),
        label: Text('Save'),
        tooltip: 'Save current tasks',
        onPressed: () => configSave(_tasks),
      );
    }
    return null;
  }

  void _createTask() {
    if (_tasks.length < _tasksMax) {
      setState(() {
        _tasks.add(
          Task(
            creationTimeStamp: DateTime.now(),
            lastModified: DateTime.now(),
            removeTask: _removeFirstTask,
            saveConfig: configSave,
          ),
        );
      });
      // for (int i = 1; i < _tasks.length; i++) {
      //   _tasks.elementAt(i).isFirstInQueue = false;
      //   _tasks.elementAt(i).state.collapse();
      // }
    }
  }

  void _removeFirstTask() {
    if (_tasks.isNotEmpty) {
      setState(() {
        _tasks.removeFirst();
      });
      _tasks.first.isFirstInQueue = true;
    }
  }

  void _switchTab(int index) {
    setState(() {
      _tabIndex = index;
    });
  }
}
