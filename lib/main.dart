import 'package:flutter/material.dart';

import 'app.dart';
import 'theme.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      title: 'QueueToDo',
      home: SafeArea(
        child: App(),
      ),
    ),
  );
}
