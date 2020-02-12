import 'package:flutter/material.dart';

get theme => ThemeData(
      brightness: Brightness.light,
      accentColorBrightness: Brightness.light,
      primaryColorBrightness: Brightness.light,
      primaryColor: Colors.yellow,
      primaryColorLight: Colors.yellow[100],
      primaryColorDark: Colors.yellow[700],
      accentColor: Colors.blue,
      buttonColor: Colors.blue,
      dividerColor: Colors.transparent, // ExpandedTile's borders when expanded.
      cardTheme: CardTheme(
        color: Colors.yellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
      ),
    );
