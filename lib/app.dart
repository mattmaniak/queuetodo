import 'package:flutter/material.dart';

import 'package:queuetodo/tabs/about.dart';
import 'package:queuetodo/tabs/usage.dart';
import 'package:queuetodo/tabs/queue_display.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  int _tabIndex = 1;

  @override
  Widget build(BuildContext context) {
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
    setState(() {
      _tabIndex = index;
    });
  }
}
