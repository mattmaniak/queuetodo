import 'package:flutter/material.dart';
// import 'button.dart';
import 'titlebar.dart';

class Layout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: <Widget>[
          TitleBar(),
          Expanded(
            child: FlutterLogo(size: 256.0)
          )
       ],
      )
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     leading: IconButton(
    //       icon: Icon(Icons.menu),
    //       tooltip: 'Navigation menu',
    //       onPressed: null,
    //     ),
    //     title: Text('awdawd'),
    //   ),
    //   body: Center(
    //     child: Button(),
    //   ),
    // );
  }
}
