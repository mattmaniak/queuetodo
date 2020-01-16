import 'package:flutter/material.dart';

import 'task.dart';

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  static const int _tasksMax = 16;
  List<Task> _tasks = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   title: Text('${_tasks.length} pending'),
        // ),
        body: Container(
          child: ListView(
            children: _tasks.toList(),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add_to_queue),
          label: Text('Create task'),
          onPressed: _createTask,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: BottomAppBar(
          child: BottomNavigationBar(
            currentIndex: 1,
            backgroundColor: Theme.of(context).primaryColor,
            selectedItemColor: Theme.of(context).accentColor,
            unselectedItemColor: Theme.of(context).iconTheme.color,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.queue,
                ),
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
          ),
        ),
      ),
    );
  }

  void _createTask() {
    if (_tasks.length < _tasksMax) {
      try {
        setState(() {
          _tasks.add(Task(creationId: DateTime.now()));
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
}
