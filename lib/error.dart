import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Display a tiny bottom bar with an error message.
void showErrorSnackBar(BuildContext context, String message) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).errorColor,
        ),
      ),
      duration: Duration(seconds: 3),
    ),
  );
}
