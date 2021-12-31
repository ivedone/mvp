import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import 'package:flutter_tts/flutter_tts.dart';

import 'do_routine.dart';
import 'countdown.dart';
import 'task.dart';

class AudioNotifier with ChangeNotifier {
  final DoRoutineModel _doRoutine;
  final CountdownModel _countdown;

  final FlutterTts flutterTts = FlutterTts();

  AudioNotifier(
      {required DoRoutineModel doRoutine, required CountdownModel countdown})
      : _countdown = countdown,
        _doRoutine = doRoutine {
    doRoutine.addListener(() => onTick());
    _initFlutterTts();
  }

  _initFlutterTts() async {
    flutterTts.setStartHandler(() => _isAnnouncing = true);
    flutterTts.setCompletionHandler(() => _isAnnouncing = false);
    flutterTts.setCancelHandler(() => _isAnnouncing = false);

    if (kIsWeb || Platform.isIOS) {
      await flutterTts.awaitSpeakCompletion(true);
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.setVolume(0.5);
      await flutterTts.setPitch(1.5);
    }

    if (Platform.isIOS) {
      await flutterTts.setSharedInstance(true);
      await flutterTts.setIosAudioCategory(
          IosTextToSpeechAudioCategory.ambient,
          [
            IosTextToSpeechAudioCategoryOptions.allowBluetooth,
            IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
            IosTextToSpeechAudioCategoryOptions.mixWithOthers
          ],
          IosTextToSpeechAudioMode.voicePrompt);
      await flutterTts.setVoice({'name': 'Siri', 'locale': 'en-US'});
    }
  }

  bool _isAnnouncing = false;
  bool get isAnnouncing => _isAnnouncing;
  bool get shouldAnnounceTask =>
      _doRoutine.isRunning &&
      !isAnnouncing &&
      _areCloseEnough(Duration.zero, _countdown.elapsed);

  announceTask(TaskModel? task) async {
    if (!isAnnouncing && task != null) {
      await flutterTts.speak(task.title);
    }
  }

  bool _areCloseEnough(Duration t1, Duration t2) {
    const int margin = 50;
    final int diff = t1.inMilliseconds - t2.inMilliseconds;
    return -margin <= diff && diff <= margin;
  }

  onTick() {
    if (shouldAnnounceTask) {
      announceTask(_countdown.task);
    }
  }
}
