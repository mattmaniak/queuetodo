import 'dart:collection';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:queuetodo/task.dart';

void configSave(Queue<Task> tasks) async {
  final preferences = await SharedPreferences.getInstance();
  final List<String> encodedTasks = [];

  for (Task taskObject in tasks) {
    try {
      encodedTasks.add(json.encode({
        'creationTimestamp': taskObject.creationTimestamp.toString(),
        'lastModified': taskObject.lastModified.toString(),
        'title': taskObject.titleController.text,
        'description': taskObject.descriptionController.text,
      }));
    } on JsonUnsupportedObjectError {
      continue;
    }
  }
  preferences.setStringList('_encodedTasks', encodedTasks);
}

Future<Queue<Task>> configRead(
    int tasksMax, Function removeTask, Function saveConfig) async {
  final preferences = await SharedPreferences.getInstance();
  final encodedTasks = preferences.getStringList('_encodedTasks') ?? [];
  Map<String, dynamic> decoded = {};
  Queue<Task> tasks = Queue();

  for (String encoded in encodedTasks) {
    if (tasks.length < tasksMax) {
      final now = DateTime.now();
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
          titleController: TextEditingController(
            text: decoded['title'],
          ),
          descriptionController: TextEditingController(
            text: decoded['description'],
          ),
        ),
      );
    }
  }
  return tasks;
}
