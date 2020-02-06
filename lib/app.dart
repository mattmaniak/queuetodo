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
  Queue<Task> _tasks = Queue();
  int _tabIndex = 1;

  _AppState() {
    configRead(_tasksMax, _popTask, _saveTasks).then((tasks) {
      setState(() {
        _tasks = tasks;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Widget _queuePopButton = _tasks.isNotEmpty
        ? _AppQueueButton(
            label: 'Pop the first task',
            tooltip: 'Remove the first task from the queue.',
            icon: Icons.delete_forever,
            onPressed: _popTask,
          )
        : Container();

    final Widget _queuePushButton = _tasks.length < _tasksMax
        ? _AppQueueButton(
            label: 'Push a task',
            tooltip: 'Add a task to the end of the queue.',
            icon: Icons.add_box,
            onPressed: _pushTask,
          )
        : Container();

    final List<List<Widget>> tabs = [
      [Usage()],
      [
        _queuePopButton,
        Column(
          children: _tasks.toList(),
        ),
        _queuePushButton,
      ],
      [About()],
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: ListView(
        children: tabs[_tabIndex],
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
    } // Else: add button isn't rendered.
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

class _AppQueueButton extends StatelessWidget {
  final String tooltip;
  final String label;
  final IconData icon;
  final Function onPressed;

  const _AppQueueButton(
      {@required this.tooltip,
      @required this.label,
      @required this.icon,
      @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        icon: Icon(this.icon),
        tooltip: this.tooltip,
        label: Text(this.label),
        onPressed: this.onPressed,
      ),
    );
  }
}
