import 'package:flutter/material.dart';
import 'package:mvp/models/task.dart';
import 'package:mvp/util/clock_format.dart';

@immutable
class OffsetAmounts {
  static const fiveSeconds = Duration(seconds: 5);
  static const negFiveSeconds = Duration(seconds: -5);

  static const tenSeconds = Duration(seconds: 10);
  static const negTenSeconds = Duration(seconds: -10);
}

class Countdown with ChangeNotifier {
  Task? _task;
  Task? get task => _task;
  bool get hasTask => task != null;

  Countdown selectTask(Task task, {Duration startElapsed = Duration.zero}) {
    restart();
    _task = task;
    _offset = startElapsed;
    notifyListeners();
    return this;
  }

  Countdown clearTask() {
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
  String get remainingString => toMinutesAndSeconds(remaining);

  double get percentDone => elapsed.inMilliseconds / duration.inMilliseconds;

  Countdown start() {
    stopwatch.start();
    notifyListeners();
    return this;
  }

  Countdown stop() {
    stopwatch.stop();
    notifyListeners();
    return this;
  }

  Countdown toggle() {
    if (isRunning) {
      stop();
    } else {
      start();
    }
    return this;
  }

  Countdown restart({bool stop = false}) {
    if (stop) this.stop();
    stopwatch.reset();
    _offset = Duration.zero;
    notifyListeners();
    return this;
  }

  Countdown complete() {
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

  Countdown offsetBy(Duration offset) {
    _offset += offset;
    notifyListeners();
    return this;
  }
}
