import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mvp/models/task.dart';
import 'package:mvp/models/user.dart';

@immutable
class Routine {
  String get key => '$title-$creator-${totalDuration.inSeconds}';
  final User creator;
  final String title;
  final List<Task> _tasks;
  List<Task> get tasks => UnmodifiableListView(_tasks);
  int get length => _tasks.length;
  late final Duration totalDuration;

  Routine({
    required this.title,
    required this.creator,
    required List<Task> tasks,
  }) : _tasks = tasks {
    _initTotalDuration();
  }

  bool isValidIndex(int i) => 0 <= i && i < length;

  Task? atIndex(int i) {
    if (isValidIndex(i)) {
      return _tasks[i];
    }
  }

  void _initTotalDuration() {
    Duration duration = Duration.zero;
    for (int i = 0; i < _tasks.length; i++) {
      duration += atIndex(i)!.duration;
    }
    totalDuration = duration;
  }
}
