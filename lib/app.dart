import 'package:flutter/material.dart';

import 'about.dart';
import 'stats.dart';
import 'queue.dart';

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final List<Widget> _tabs = [Queue(), Stats(), About()];
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _tabs[_tabIndex],
        floatingActionButton: _floatingButton,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: BottomAppBar(
          child: BottomNavigationBar(
            backgroundColor: Theme.of(context).primaryColor,
            selectedItemColor: Theme.of(context).accentColor,
            unselectedItemColor: Theme.of(context).iconTheme.color,
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
            onTap: (index) {
              setState(() {
                _tabIndex = index;
                debugPrint(index.toString());
              });
            },
          ),
        ),
      ),
    );
  }

  Widget get _floatingButton {
    if (_tabIndex == 0) {
      return FloatingActionButton.extended(
        icon: Icon(Icons.add_to_queue),
        label: Text('Create task'),
        // onPressed: _createTask,
        onPressed: null,
      );
    }
    return null;
  }

  // void _createTask() {
  //   if (_tasks.length < _tasksMax) {
  //     try {
  //       setState(() {
  //         _tasks.add(Task(creationId: DateTime.now()));
  //       });
  //     } on UnsupportedError {
  //       // Fixed size list.
  //     }
  //   }
  // }

  // void _removeTask() {
  //   if (_tasks.isNotEmpty) {
  //     try {
  //       setState(() {
  //         _tasks.remove(_tasks.first);
  //       });
  //     } on UnsupportedError {
  //       // Fixed size list.
  //     }
  // }
  // }
}
