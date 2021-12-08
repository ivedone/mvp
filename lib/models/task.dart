import 'package:flutter/material.dart';

enum TaskType {
  work,
  rest,
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
