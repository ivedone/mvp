import 'package:flutter/foundation.dart' show ChangeNotifier;

import 'package:mvp/services/countdown.dart';
import 'package:mvp/services/do_routine.dart';
import 'package:mvp/models/task.dart';

import 'announcer/countdown_announcer.dart';
import 'announcer/task_announcer.dart';

enum AudioNotifierState { loading, muted, all }

class AudioNotifier with ChangeNotifier {
  final DoRoutineModel _doRoutine;
  final CountdownModel _countdown;

  Duration get elapsed => _countdown.elapsed;
  Duration get remaining => _countdown.remaining;

  bool get hasTask => _doRoutine.hasTask;
  TaskModel? get currentTask => _doRoutine.currentTask;

  AudioNotifier({required DoRoutineModel doRoutine})
      : _doRoutine = doRoutine,
        _countdown = doRoutine.countdown {
    _doRoutine.addListener(() {
      onTick();
    });
    init();
  }

  AudioNotifierState _state = AudioNotifierState.loading;
  AudioNotifierState get state => _state;
  set state(AudioNotifierState state) {
    _state = state;
    notifyListeners();
  }

  bool get loading => state == AudioNotifierState.loading;
  bool get muted => state == AudioNotifierState.muted;
  bool get all => state == AudioNotifierState.all;

  toggle() async {
    if (loading) return;
    if (muted) {
      state = AudioNotifierState.all;
    } else {
      state = AudioNotifierState.muted;
    }
    notifyListeners();
  }

  init() async {
    state = AudioNotifierState.all;
    await _taskAnnouncer.init();
    await _countdownAnnouncer.init();
  }

  final _taskAnnouncer = TaskAnnouncer();
  final _countdownAnnouncer = CountdownAnnouncer();

  onTick() {
    if (muted || _doRoutine.isPaused) return;
    if (hasTask) {
      _taskAnnouncer.start(elapsed, currentTask!);
    }
    _countdownAnnouncer.start(remaining, null);
  }
}
