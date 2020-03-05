import 'package:flutter/material.dart';

import 'package:localize_and_translate/localize_and_translate.dart';

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
          title: Text(translator.translate('test')),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.queue),
          title: Text('Queue'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.description),
          title: Text('About'),
        ),
      ],
      onTap: this.onTap,
    );
  }
}
