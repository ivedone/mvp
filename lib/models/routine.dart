import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mvp/models/task.dart';
import 'package:mvp/models/user.dart';

@immutable
class RoutineModel {
  final UserModel creator;
  final String title;
  final List<TaskModel> _tasks;
  List<TaskModel> get tasks => UnmodifiableListView(_tasks);
  int get length => _tasks.length;

  const RoutineModel({
    required this.title,
    required this.creator,
    required List<TaskModel> tasks,
  }) : _tasks = tasks;

  bool isValidIndex(int i) => 0 <= i && i < length;

  TaskModel? atIndex(int i) {
    if (isValidIndex(i)) {
      return _tasks[i];
    }
  }
}
