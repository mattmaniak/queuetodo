import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  16.0,
                ),
              ),
            ),
            child: ListTile(
              title: Text('Created by mattmaniak.'),
              trailing: Icon(Icons.open_in_new),
            ),
          ),
        ],
      ),
    );
  }
}
