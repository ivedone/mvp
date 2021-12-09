import 'package:flutter/material.dart';
import 'package:mvp/models/task.dart';

@immutable
class OffsetAmounts {
  static const fiveSeconds = Duration(seconds: 5);
  static const negFiveSeconds = Duration(seconds: -5);
}

class CountdownModel with ChangeNotifier {
  TaskModel? _task;
  TaskModel? get task => _task;
  bool get hasTask => task != null;

  CountdownModel selectTask(TaskModel task,
      {Duration startElapsed = Duration.zero}) {
    restart();
    _task = task;
    _offset = startElapsed;
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

  bool get didSkipPastTask => isDone;
  Duration get excessSkippedPast =>
      didSkipPastTask ? elapsed - duration : Duration.zero;

  bool get didSkipBeforeTask => elapsed.isNegative;
  Duration get excessSkippedBefore =>
      didSkipBeforeTask ? elapsed : Duration.zero;

  CountdownModel offsetBy(Duration offset) {
    _offset += offset;
    notifyListeners();
    return this;
  }
}
