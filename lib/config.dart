import 'dart:collection';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'task.dart';

void configSave(Queue<Task> tasks) async {
  final preferences = await SharedPreferences.getInstance();
  List<String> encodedTasks = List(tasks.length);

  for (int i = 0; i < tasks.length; i++) {
    try {
      encodedTasks[i] = json.encode({
        'creationTimeStamp': tasks.elementAt(i).creationTimeStamp.toString(),
        'lastModified': tasks.elementAt(i).lastModified.toString(),
        'title': tasks.elementAt(i).title,
        'description': tasks.elementAt(i).description
      });
    } on JsonUnsupportedObjectError {
      debugPrint('json');
    }
  }
  preferences.setStringList('_encodedTasks', encodedTasks);
}

Future<Queue<Task>> configRead(Function removeTask, Function saveConfig) async {
  final preferences = await SharedPreferences.getInstance();
  List<String> encodedTasks = preferences.getStringList('_encodedTasks') ?? [];
  Queue<Task> tasks = Queue();
  Map<String, dynamic> decodedTask = {};

  encodedTasks.forEach((encodedTask) {
    try {
      decodedTask = json.decode(encodedTask);
    } on FormatException {
      debugPrint('format');
    }
    tasks.add(
      Task(
        creationTimeStamp: DateTime.tryParse(decodedTask['creationTimeStamp']),
        lastModified: DateTime.tryParse(decodedTask['lastModified']),
        removeTask: removeTask,
        saveConfig: saveConfig,
        title: decodedTask['title'],
        description: decodedTask['description'],
      ),
    );
  });
  if (tasks.isNotEmpty) {
    tasks.first.isFirstInQueue = true;
  }
  return tasks;
}
