import 'package:flutter/material.dart';
import 'package:queuetodo/lower_bar.dart';

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
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: ListView(
        children: [
          [
            Usage(),
            QueueDisplay(),
            About(),
          ].elementAt(_tabIndex)
        ],
      ),
      bottomNavigationBar: LowerBar(
        index: _tabIndex,
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
