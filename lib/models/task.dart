import 'package:flutter/material.dart';
import 'package:mvp/theme/theme.dart';

enum TaskType {
  work,
  rest,
}

ThemeData getTaskTheme(TaskType type) {
  switch (type) {
    case TaskType.work:
      return activeTheme;
    case TaskType.rest:
      return restTheme;
  }
}

@immutable
class TaskModel {
  final int? id;
  final TaskType type;
  final String title;
  final String? description;
  final Duration duration;

  const TaskModel({
    this.id,
    required this.type,
    required this.title,
    this.description,
    required this.duration,
  });

  factory TaskModel.work({
    int? id,
    required String title,
    String? description,
    required int seconds,
  }) {
    return TaskModel(
        title: title,
        type: TaskType.work,
        description: description,
        duration: Duration(seconds: seconds));
  }

  factory TaskModel.rest({
    int? id,
    required seconds,
  }) {
    return TaskModel(
        id: id,
        type: TaskType.rest,
        title: 'Rest',
        duration: Duration(seconds: seconds));
  }
}
