import 'package:flutter/material.dart';

final Color _primaryColor = Colors.amber[300];
final Color _accentColor = Colors.lightBlueAccent[400];

/// App's global theme.
get theme => ThemeData(
      brightness: Brightness.light,
      accentColorBrightness: Brightness.light,
      primaryColorBrightness: Brightness.light,
      primaryColor: _primaryColor,
      accentColor: _accentColor,
      buttonColor: _accentColor,
      cursorColor: _accentColor,
      dividerColor: Colors.transparent, // ExpandedTile's borders when expanded.
      cardTheme: CardTheme(
        color: _primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
      ),
    );
