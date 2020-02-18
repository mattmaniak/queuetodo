import 'dart:collection';

import 'package:test/test.dart';

import 'package:queuetodo/config.dart';
import 'package:queuetodo/task.dart';

void main() async {
  const tasksMax = 1;
  final Queue<Task> tasks = await configRead(tasksMax, () {}, () {});
  expect(tasks.length, tasksMax);
}
