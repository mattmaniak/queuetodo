import 'package:flutter/material.dart';

import 'package:queuetodo/app.dart';
import 'package:queuetodo/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      theme: theme,
      title: 'QueueToDo',
      home: SafeArea(
        child: App(),
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
