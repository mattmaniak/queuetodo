library todoqueue;

import 'package:flutter/material.dart';
import 'titlebar.dart' as queuetodo;

class Layout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          queuetodo.TitleBar(title: "Your Queue"),
          Expanded(
            child: FlutterLogo(size: 256.0)
          )
       ],
      )
    );
  }
}
