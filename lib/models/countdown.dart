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
}
