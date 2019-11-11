import 'package:flutter/material.dart';

class TitleBar extends StatefulWidget {
  _TitleBarState createState() => _TitleBarState();
}

class _TitleBarState extends State<TitleBar> {
  int _counter = 0;

  void _increment() {
    setState(() {
      // This call to setState tells the Flutter framework that
      // something has changed in this State, which causes it to rerun
      // the build method below so that the display can reflect the
      // updated values. If you change _counter without calling
      // setState(), then the build method won't be called again,
      // and so nothing would appear to happen.
      _counter++;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360.0,
      height: 96.0,
      color: Colors.grey[400],

      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Navigation menu',
            onPressed: _increment, // null disables the button
          ),
          Text('Tasks to do: $_counter'),
        ],
      ),
    );
  }
}
