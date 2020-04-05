import 'package:flutter/material.dart';

import 'package:queuetodo/localization.dart';
import 'package:queuetodo/tabs/about.dart';
import 'package:queuetodo/tabs/usage.dart';
import 'package:queuetodo/tabs/queue_display.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

/// Layout renderer and tab switcher.
class _AppState extends State<App> with SingleTickerProviderStateMixin {
  final List<Widget> _tabs = [
    QueueDisplay(),
    Usage(),
    About(),
  ];
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: _tabs.length);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        body: TabBarView(
          controller: _controller,
          children: _tabs,
        ),
        bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).primaryColor,
          child: TabBar(
            controller: _controller,
            labelColor: Theme.of(context).accentColor,
            unselectedLabelColor: Theme.of(context).iconTheme.color,
            tabs: [
              Tab(
                icon: Icon(Icons.queue),
                text: Localization.of(context).words['lower_bar']['queue'],
              ),
              Tab(
                icon: Icon(Icons.help_outline),
                text: Localization.of(context).words['lower_bar']['usage'],
              ),
              Tab(
                icon: Icon(Icons.description),
                text: Localization.of(context).words['lower_bar']['about'],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
