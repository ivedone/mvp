import 'package:flutter/material.dart';
import 'dart:io';

import 'package:mvp/theme/theme.dart';

enum TaskState {
  idle,
  active,
  done,
}

TaskState getTaskState(int taskIndex, int currentIndex) {
  if (currentIndex < taskIndex) {
    return TaskState.idle;
  } else if (currentIndex == taskIndex) {
    return TaskState.active;
  } else {
    return TaskState.done;
  }
}

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
class Task {
  final int? id;
  final TaskType type;
  final String title;
  final String? description;
  final Duration duration;
  final File? video;
  bool get hasVideo => video != null;

  const Task({
    this.id,
    required this.type,
    required this.title,
    this.description,
    required this.duration,
    this.video,
  });

  factory Task.work({
    int? id,
    required String title,
    String? description,
    required int seconds,
  }) {
    return Task(
        title: title,
        type: TaskType.work,
        description: description,
        duration: Duration(seconds: seconds));
  }

  factory Task.rest({
    int? id,
    required seconds,
  }) {
    return Task(
        id: id,
        type: TaskType.rest,
        title: 'Rest',
        duration: Duration(seconds: seconds));
  }
}
