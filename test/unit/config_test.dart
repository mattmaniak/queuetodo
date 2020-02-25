import 'dart:collection';

import 'package:flutter_test/flutter_test.dart';
import 'package:test/test.dart' as test;


import 'package:queuetodo/config.dart';
import 'package:queuetodo/task.dart';


void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  const tasksMax = 2;
  final Queue<Task> tasks = await configRead(0, () {}, () {});
  test.expect(tasks.length, tasksMax);
}
