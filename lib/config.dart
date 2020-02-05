import 'dart:collection';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'task.dart';

void configSave(Queue<Task> tasks) async {
  final preferences = await SharedPreferences.getInstance();
  final List<String> encodedTasks = List(tasks.length);

  for (int i = 0; i < tasks.length; i++) {
    try {
      encodedTasks[i] = json.encode({
        'creationTimestamp': tasks.elementAt(i).creationTimestamp.toString(),
        'lastModified': tasks.elementAt(i).lastModified.toString(),
        'title': tasks.elementAt(i).title,
        'description': tasks.elementAt(i).description
      });
    } on JsonUnsupportedObjectError {
      // ...
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
        debugPrint('format');
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
