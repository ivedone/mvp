import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mvp/services/countdown.dart';
import 'package:mvp/models/routine.dart';
import 'package:mvp/models/task.dart';
import 'package:mvp/util/clock_format.dart';

class DoRoutine extends ChangeNotifier {
  RoutineModel? _routine;
  RoutineModel? get routine => _routine;
  bool get hasRoutine => routine != null;

  late final Ticker _ticker;
  bool get isRunning => _ticker.isActive;
  bool get isPaused => !isRunning;
  final Countdown countdown;

  DoRoutine({
    required this.countdown,
  }) {
    _initTicker();
  }

  void _initTicker() {
    _ticker = Ticker(_onTick);
  }

  DoRoutine start() {
    _ticker.start();
    countdown.start();
    notifyListeners();
    return this;
  }

  DoRoutine stop() {
    _ticker.stop();
    countdown.stop();
    notifyListeners();
    return this;
  }

  TaskModel? atIndex(int i) {
    return _routine!.atIndex(i);
  }

  DoRoutine toggle() {
    if (isRunning) {
      stop();
    } else {
      start();
    }
    return this;
  }

  DoRoutine restart() {
    selectTaskAtIndex(0);
    return this;
  }

  DoRoutine selectRoutine(RoutineModel routine) {
    _routine = routine;
    _index = 0;
    countdown.selectTask(currentTask!);
    notifyListeners();
    return this;
  }

  DoRoutine clearRoutine() {
    stop();
    _routine = null;
    notifyListeners();
    return this;
  }

  DoRoutine selectTaskAtIndex(int i,
      {Duration startElapsed = Duration.zero, bool forceDontStart = false}) {
    if (isValidIndex(i)) {
      _index = i;
      countdown.selectTask(
        currentTask!,
        startElapsed: startElapsed,
      );
      _calculatePrevElapsed();
      if (!forceDontStart && isPaused) start();
      notifyListeners();
    }
    return this;
  }

  /// Iterator
  int _index = 0;
  int get index => _index;
  int get length => hasRoutine ? routine!.length : 0;
  bool isValidIndex(int i) => routine?.isValidIndex(i) ?? false;
  bool get hasTask => isValidIndex(index);
  TaskModel? get currentTask => routine?.atIndex(index);
  bool get isDone => index >= length;

  bool get isLast => isValidIndex(index) && index == length - 1;
  bool get hasNext => isValidIndex(index) && !isLast;

  Duration _prevElapsed = Duration.zero;
  Duration get elapsed =>
      hasTask ? _prevElapsed + countdown.elapsed : Duration.zero;
  String get elapsedString => toMinutesAndSeconds(elapsed);
  Duration get remaining =>
      hasRoutine ? routine!.totalDuration - elapsed : Duration.zero;
  String get remainingString => toMinutesAndSeconds(remaining);

  void _calculatePrevElapsed() {
    _prevElapsed = Duration.zero;
    if (isValidIndex(index)) {
      for (int i = 0; i < index; i++) {
        final TaskModel task = routine!.atIndex(i)!;
        _prevElapsed += task.duration;
      }
    }
    notifyListeners();
  }

  DoRoutine skipForward({Duration startElapsed = Duration.zero}) {
    if (isValidIndex(index)) {
      _index++;
      if (isDone) {
        countdown.clearTask();
      } else {
        countdown.selectTask(currentTask!, startElapsed: startElapsed);
        if (index > 0) {
          final TaskModel prevTask = routine!.atIndex(index - 1)!;
          _prevElapsed += prevTask.duration;
        }
      }
      notifyListeners();
    }
    return this;
  }

  DoRoutine skipBack({Duration offset = Duration.zero}) {
    if (isValidIndex(index)) {
      if (index == 0 || countdown.elapsed.inSeconds > 5) {
        countdown.restart();
      } else {
        _index--;
        final TaskModel task = currentTask!;
        _prevElapsed -= task.duration;
        if (offset.isNegative) {
          countdown.selectTask(task, startElapsed: task.duration + offset);
        } else {
          countdown.selectTask(task);
        }
      }
      notifyListeners();
    }
    return this;
  }

  DoRoutine skipForward10Sec() {
    countdown.offsetBy(OffsetAmounts.tenSeconds);
    while (countdown.hasTask && countdown.didSkipPastTask) {
      skipForward(startElapsed: countdown.excessSkippedPast);
    }
    notifyListeners();
    return this;
  }

  DoRoutine skipBack10Sec() {
    countdown.offsetBy(OffsetAmounts.negTenSeconds);
    while (countdown.hasTask && countdown.didSkipBeforeTask) {
      skipBack(offset: countdown.excessSkippedBefore);
    }
    return this;
  }

  void _onTick(_) {
    countdown.notifyListeners();
    if (!hasRoutine || isDone) {
      stop();
    } else if (countdown.isDone) {
      skipForward(startElapsed: countdown.excessSkippedPast);
    }
    notifyListeners();
  }

  bool get shouldNotRender => isDone || !hasRoutine || !hasTask;
}
