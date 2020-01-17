import 'package:flutter/material.dart';

import 'about.dart';
import 'stats.dart';
import 'task.dart';
import 'queue.dart';

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  static const int _tasksMax = 16;
  static List<Task> _tasks = [];
  List<Widget> _tabs;
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    _tabs = [Queue(tasks: _tasks), Stats(), About()];

    return SafeArea(
      child: Scaffold(
        body: _tabs[_tabIndex],
        floatingActionButton: _floatingButton,
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
                icon: Icon(Icons.score),
                title: Text('Stats'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.info),
                title: Text('About'),
              ),
            ],
            onTap: _switchTab,
          ),
        ),
      ),
    );
  }

  Widget get _floatingButton {
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
    if (_tasks.length < _tasksMax) {
      try {
        setState(() {
          _tasks.add(
            Task(
              creationId: DateTime.now(),
              removeTask: _removeTask,
            ),
          );
        });
      } on UnsupportedError {
        // Fixed size list.
      }
    }
  }

  void _removeTask() {
    if (_tasks.isNotEmpty) {
      try {
        setState(() {
          _tasks.remove(_tasks.first);
        });
      } on UnsupportedError {
        // Fixed size list.
      }
    }
  }

  void _switchTab(int index) {
    setState(() {
      _tabIndex = index;
    });
  }
}
