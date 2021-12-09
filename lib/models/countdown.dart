import 'package:flutter/material.dart';
import 'package:mvp/models/task.dart';

class CountdownModel with ChangeNotifier {
  TaskModel? _task;
  TaskModel? get task => _task;
  bool get hasTask => task != null;

  void selectTask(TaskModel task) {
    _task = task;
    notifyListeners();
  }

  void clearTask() {
    _task = null;
    notifyListeners();
  }

  final Stopwatch stopwatch = Stopwatch();
  bool get isRunning => stopwatch.isRunning;
  bool get isPaused => !isRunning;

  void start() {
    stopwatch.start();
    notifyListeners();
  }

  void stop() {
    stopwatch.stop();
    notifyListeners();
  }

  void toggle() {
    if (isRunning) {
      stop();
    } else {
      start();
    }
  }
}
