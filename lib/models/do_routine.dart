import 'package:flutter/material.dart';
import 'package:mvp/models/countdown.dart';
import 'package:mvp/models/routine.dart';
import 'package:mvp/models/task.dart';

enum DoRoutineActionTypes {
  selectRoutine,
  clearRoutine,
  start,
  stop,
  skipForward,
  skipBack,
  selectTaskAtIndex,
  restart,
  skipForward5Sec,
  skipBack5Sec,
}

class DoRoutineModel extends ChangeNotifier {
  RoutineModel? _routine;
  RoutineModel? get routine => _routine;
  bool get hasRoutine => routine != null;

  final CountdownModel _countdown;
  DoRoutineModel({required CountdownModel countdown}) : _countdown = countdown;

  DoRoutineModel selectRoutine(RoutineModel routine) {
    _routine = routine;
    _index = 0;
    _countdown.selectTask(currentTask!);
    notifyListeners();
    return this;
  }

  DoRoutineModel clearRoutine() {
    _routine = null;
    notifyListeners();
    return this;
  }

  DoRoutineModel selectTaskAtIndex(int i) {
    if (isValidIndex(i)) {
      _index = i;
      _countdown.selectTask(currentTask!);
      notifyListeners();
    }
    return this;
  }

  /// Iterator
  int _index = 0;
  int get index => _index;
  int get length => hasRoutine ? routine!.length : 0;
  bool isValidIndex(int i) => routine?.isValidIndex(i) ?? false;
  TaskModel? get currentTask => routine?.atIndex(index);
  bool get isDone => index >= length;

  bool get isLast => isValidIndex(index) && index == length - 1;
  bool get hasNext => isValidIndex(index) && !isLast;
  DoRoutineModel skipForward() {
    if (isValidIndex(index)) {
      _index++;
      if (isDone) {
        _countdown.clearTask();
      } else {
        _countdown.selectTask(currentTask!);
      }
      notifyListeners();
    }
    return this;
  }

  DoRoutineModel skipBack() {
    if (isValidIndex(index)) {
      if (index == 0) {
        _countdown.restart();
      } else {
        _index--;
        _countdown.selectTask(currentTask!);
      }
      notifyListeners();
    }
    return this;
  }
}
