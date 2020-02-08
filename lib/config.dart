import 'dart:collection';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'task.dart';

void configSave(Queue<Task> tasks, int tasksMax) async {
  final preferences = await SharedPreferences.getInstance();
  final List<String> encodedTasks = [];

  for (Task taskObject in tasks) {
    if (encodedTasks.length < tasksMax) {
      try {
        encodedTasks.add(json.encode({
          'creationTimestamp': taskObject.creationTimestamp.toString(),
          'lastModified': taskObject.lastModified.toString(),
          'title': taskObject.title,
          'description': taskObject.description
        }));
      } on JsonUnsupportedObjectError {
        continue;
      }
    }
  }
  preferences.setStringList('_encodedTasks', encodedTasks);
}

Future<Queue<Task>> configRead(
    int tasksMax, Function removeTask, Function saveConfig) async {
  final preferences = await SharedPreferences.getInstance();
  final List<String> encodedTasks =
      preferences.getStringList('_encodedTasks') ?? [];
  Map<String, dynamic> decoded = {};
  Queue<Task> tasks = Queue();

  for (String encoded in encodedTasks) {
    final now = DateTime.now();

    if (tasks.length < tasksMax) {
      try {
        decoded = json.decode(encoded);
      } on FormatException {
        continue;
      }
      tasks.add(
        Task(
          creationTimestamp:
              DateTime.tryParse(decoded['creationTimestamp']) ?? now,
          lastModified: DateTime.tryParse(decoded['lastModified']) ?? now,
          removeTask: removeTask,
          saveConfig: saveConfig,
          title: decoded['title'] ?? '',
          description: decoded['description'] ?? '',
        ),
      );
    }
  }
  return tasks;
}
