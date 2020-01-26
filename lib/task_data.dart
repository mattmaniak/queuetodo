import 'dart:collection';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'task.dart';

class TaskData {
  List<String> _encodedTasks = [];

  Future<Queue<Task>> read(Function removeTask, Function saveConfig) async {
    final preferences = await SharedPreferences.getInstance();
    Queue<Task> tasks = Queue();
    Map<String, dynamic> decodedTask;

    _encodedTasks = preferences.getStringList('_encodedTasks') ?? [];
    _encodedTasks.forEach((encodedTask) {
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

  void save(Queue<Task> tasks) async {
    final preferences = await SharedPreferences.getInstance();

    for (int i = 0; i < tasks.length; i++) {
      try {
        _encodedTasks.add(
          json.encode({
            'creationTimeStamp': tasks.elementAt(i).creationTimeStamp.toString(),
            'lastModified': tasks.elementAt(i).lastModified.toString(),
            'title': tasks.elementAt(i).title,
            'description': tasks.elementAt(i).description
          }),
        );
      } on JsonUnsupportedObjectError {
        debugPrint('json');
      }
    }
    preferences.setStringList('_encodedTasks', _encodedTasks);
  }
}
