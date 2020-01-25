import 'dart:collection';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'task.dart';

class TaskData {
  List<String> _encodedTasks = [];

  Future<Queue<Task>> get read async {
    Queue<Task> tasks = Queue();
    final preferences = await SharedPreferences.getInstance();

    _encodedTasks = preferences.getStringList('_encodedTasks') ?? [];
    if (_encodedTasks.length > 0) {
      _encodedTasks.forEach((encodedTask) {
        tasks.add(json.decode(encodedTask));
      });
    }
    if (tasks == null) {
      return Queue();
    }
    return tasks;
  }

  void save(Queue<Task> tasks) async {
    final preferences = await SharedPreferences.getInstance();
    _encodedTasks.clear();

    for (int i = 0; i < tasks.length; i++) {
      try {
        _encodedTasks.add(tasks.elementAt(i).toJson(tasks.elementAt(i)).toString());
      } on JsonUnsupportedObjectError {

      }
    }
    preferences.setStringList('_encodedTasks', _encodedTasks);
  }
}
