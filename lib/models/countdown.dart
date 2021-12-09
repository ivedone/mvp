import 'package:flutter/material.dart';
import 'package:mvp/models/task.dart';

enum CountdownActionTypes {
  selectTask,
  clearTask,
  start,
  stop,
  toggle,
  restart,
  complete,
  skipForward5Sec,
  skipBack5Sec,
}

class CountdownModel with ChangeNotifier {
  TaskModel? _task;
  TaskModel? get task => _task;
  bool get hasTask => task != null;

  CountdownModel selectTask(TaskModel task) {
    _task = task;
    notifyListeners();
    return this;
  }

  CountdownModel clearTask() {
    restart(stop: true);
    _task = null;
    notifyListeners();
    return this;
  }

  final Stopwatch stopwatch = Stopwatch();
  bool get isRunning => stopwatch.isRunning;
  bool get isPaused => !isRunning;

  Duration _offset = Duration.zero;
  Duration get elapsed => stopwatch.elapsed + _offset;
  Duration get duration => hasTask ? task!.duration : Duration.zero;
  Duration get _diff => duration - elapsed;
  bool get isDone => _diff.compareTo(Duration.zero) < 1;
  Duration get remaining => isDone ? Duration.zero : _diff;

  CountdownModel start() {
    stopwatch.start();
    notifyListeners();
    return this;
  }

  CountdownModel stop() {
    stopwatch.stop();
    notifyListeners();
    return this;
  }

  CountdownModel toggle() {
    if (isRunning) {
      stop();
    } else {
      start();
    }
    return this;
  }

  CountdownModel restart({bool stop = false}) {
    if (stop) this.stop();
    stopwatch.reset();
    _offset = Duration.zero;
    notifyListeners();
    return this;
  }

  CountdownModel complete() {
    _offset += remaining;
    notifyListeners();
    return this;
  }
}
