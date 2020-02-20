import 'dart:collection';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:test/test.dart' as test;

import 'package:queuetodo/config.dart';
import 'package:queuetodo/task.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  const tasksMax = 0;
  final Queue<Task> tasks = await configRead(tasksMax, () {}, () {});
  test.expect(tasks.length, tasksMax);
}
