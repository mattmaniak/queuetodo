import 'package:flutter/material.dart';

import 'package:queuetodo/tabs/about.dart';
import 'package:queuetodo/tabs/usage.dart';
import 'package:queuetodo/tabs/queue_display.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // static const int _tasksMax = 100;

  int _tabIndex = 1;
  // Queue<Task> _tasks = Queue();

  // _AppState() {
  //   configRead(_tasksMax, _popTask, _saveTasks).then((tasks) {
  //     setState(() {
  //       _tasks = tasks;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // final Widget _popButton = _queueButton(
    //   label: 'Pop the first task',
    //   tooltip: 'Remove the first task from the queue.',
    //   icon: Icons.delete_forever,
    //   onPressed: _popTask,
    // );

    // final Widget _pushButton = _queueButton(
    //   label: 'Push a task',
    //   tooltip: 'Add a task to the end of the queue.',
    //   icon: Icons.add_box,
    //   onPressed: _pushTask,
    // );

    final List<List<Widget>> tabs = [
      [Usage()],
      [QueueDisplay()],
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

  void _switchTab(int index) {
    if (_tabIndex != index) {
      setState(() {
        _tabIndex = index;
        // configRead(_tasksMax, _popTask, _saveTasks).then((tasks) {
        //   _tasks = tasks;
        // });
      });
    }
  }
}
