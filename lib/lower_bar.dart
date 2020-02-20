import 'package:flutter/material.dart';

class LowerBar extends StatelessWidget {
  final int index;
  final Function onTap;

  const LowerBar({@required this.index, @required this.onTap});

  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Theme.of(context).accentColor,
      unselectedItemColor: Theme.of(context).iconTheme.color,
      type: BottomNavigationBarType.shifting,
      currentIndex: index,
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
      onTap: this.onTap,
    );
  }
}
