library todoqueue;

import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  TitleBar({this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360.0,
      height: 96.0,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
      color: Colors.green[300],
      child: Text(this.title)
    );
  }
}
