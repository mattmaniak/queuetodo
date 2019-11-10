import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  TitleBar({this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(this.title)
    );
  }
}

class QueueToDo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          TitleBar(
            title: "Your Queue"
          ),
          Text('World')
       ],
      )
    );
  }
}
