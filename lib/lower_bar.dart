import 'package:flutter/material.dart';

import 'package:queuetodo/localization.dart';

/// App's bottom navigation to switch between screens (tabs).
class LowerBar extends StatelessWidget {
  final int index;
  final Function onTap;

  const LowerBar({@required this.index, @required this.onTap});

  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColorDark,
      selectedItemColor: Theme.of(context).accentColor,
      unselectedItemColor: Theme.of(context).iconTheme.color,
      showSelectedLabels: true,
      currentIndex: index,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.help_outline),
          title: Text(Localization.of(context).words['lower_bar']['usage']),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.queue),
          title: Text(Localization.of(context).words['lower_bar']['queue']),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.description),
          title: Text(Localization.of(context).words['lower_bar']['about']),
        ),
      ],
      onTap: this.onTap,
    );
  }
}
