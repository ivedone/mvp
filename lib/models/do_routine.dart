import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mvp/models/countdown.dart';
import 'package:mvp/models/routine.dart';
import 'package:mvp/models/task.dart';
import 'package:mvp/util/clock_format.dart';

class DoRoutineModel extends ChangeNotifier {
  RoutineModel? _routine;
  RoutineModel? get routine => _routine;
  bool get hasRoutine => routine != null;

  late final Ticker _ticker;
  bool get isRunning => _ticker.isActive;
  bool get isPaused => !isRunning;
  final CountdownModel _countdown;

  DoRoutineModel({required CountdownModel countdown}) : _countdown = countdown {
    _initTicker();
  }

  void _initTicker() {
    _ticker = Ticker(_onTick);
  }

  DoRoutineModel start() {
    _ticker.start();
    _countdown.start();
    notifyListeners();
    return this;
  }

  DoRoutineModel stop() {
    _ticker.stop();
    _countdown.stop();
    notifyListeners();
    return this;
  }

  TaskModel? atIndex(int i) {
    return _routine!.atIndex(i);
  }

  DoRoutineModel toggle() {
    if (isRunning) {
      stop();
    } else {
      start();
    }
    return this;
  }

  DoRoutineModel restart() {
    selectTaskAtIndex(0);
    return this;
  }

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

  DoRoutineModel selectTaskAtIndex(int i,
      {Duration startElapsed = Duration.zero}) {
    if (isValidIndex(i)) {
      _index = i;
      _countdown.selectTask(
        currentTask!,
        startElapsed: startElapsed,
      );
      _calculatePrevElapsed();
      if (isPaused) start();
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
      hasTask ? _prevElapsed + _countdown.elapsed : Duration.zero;
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

  DoRoutineModel skipForward({Duration startElapsed = Duration.zero}) {
    if (isValidIndex(index)) {
      _index++;
      if (isDone) {
        _countdown.clearTask();
      } else {
        _countdown.selectTask(currentTask!, startElapsed: startElapsed);
        if (index > 0) {
          final TaskModel prevTask = routine!.atIndex(index - 1)!;
          _prevElapsed += prevTask.duration;
        }
      }
      notifyListeners();
    }
    return this;
  }

  DoRoutineModel skipBack({Duration offset = Duration.zero}) {
    if (isValidIndex(index)) {
      if (index == 0 || _countdown.elapsed.inSeconds > 5) {
        _countdown.restart();
      } else {
        _index--;
        final TaskModel task = currentTask!;
        _prevElapsed -= task.duration;
        if (offset.isNegative) {
          _countdown.selectTask(task, startElapsed: task.duration + offset);
        } else {
          _countdown.selectTask(task);
        }
      }
      notifyListeners();
    }
    return this;
  }

  DoRoutineModel skipForward5Sec() {
    _countdown.offsetBy(OffsetAmounts.fiveSeconds);
    while (_countdown.hasTask && _countdown.didSkipPastTask) {
      skipForward(startElapsed: _countdown.excessSkippedPast);
    }
    notifyListeners();
    return this;
  }

  DoRoutineModel skipBack5Sec() {
    _countdown.offsetBy(OffsetAmounts.negFiveSeconds);
    while (_countdown.hasTask && _countdown.didSkipBeforeTask) {
      skipBack(offset: _countdown.excessSkippedBefore);
    }
    return this;
  }

  void _onTick(_) {
    _countdown.notifyListeners();
    if (!hasRoutine || isDone) {
      stop();
    } else if (_countdown.isDone) {
      skipForward(startElapsed: _countdown.excessSkippedPast);
    }
    notifyListeners();
  }

  bool get shouldNotRender => isDone || !hasRoutine || !hasTask;
}
