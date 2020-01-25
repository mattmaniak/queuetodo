import 'dart:collection';

import 'package:flutter/material.dart';

import 'about.dart';
import 'how_to.dart';
import 'task.dart';
import 'tasks_queue.dart';

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  static const int _tasksMax = 16;
  Queue<Task> _tasks = Queue();
  List<Widget> _tabs;
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    _tabs = [TasksQueue(tasks: _tasks), HowTo(), About()];

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
      return FloatingActionButton(
        child: Icon(Icons.add_to_queue),
        tooltip: 'Create task',
        onPressed: _createTask,
      );
    }
    return null;
  }

  void _createTask() {
    bool isFirst = true;

    if (_tasks.length > 0) {
      isFirst = false;
    }
    if (_tasks.length < _tasksMax) {
      setState(() {
        _tasks.add(
          Task(
            idWhenCreated: DateTime.now(),
            isFirstInQueue: isFirst,
            removeTask: _removeTask,
          ),
        );
      });
      for (int i = 1; i < _tasks.length; i++) {
        _tasks.elementAt(i).isFirstInQueue = false;
      }
    }
  }

  void _removeTask() {
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
