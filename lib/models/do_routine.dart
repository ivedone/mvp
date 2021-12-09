import 'package:flutter/material.dart';
import 'package:mvp/models/routine.dart';

enum DoRoutineActionTypes {
  selectRoutine,
  clearRoutine,
  start,
  stop,
  restart,
  skipForward,
  skipBack,
  skipForward5Sec,
  skipBack5Sec,
}

class DoRoutineModel extends ChangeNotifier {
  RoutineModel? _routine;
  RoutineModel? get routine => _routine;
  bool get hasRoutine => routine != null;

  DoRoutineModel selectRoutine(RoutineModel routine) {
    _routine = routine;
    notifyListeners();
    return this;
  }

  DoRoutineModel clearRoutine() {
    _routine = null;
    notifyListeners();
    return this;
  }
}
