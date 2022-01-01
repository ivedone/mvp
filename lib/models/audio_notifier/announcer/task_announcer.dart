import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_tts/flutter_tts.dart';

import 'package:mvp/models/task.dart';

import 'announcer.dart';

class TaskAnnouncer extends Announcer<TaskModel> {
  final FlutterTts _flutterTts = FlutterTts();

  TaskAnnouncer() : super(target: Duration.zero) {
    _initFlutterTts();
  }

  bool _isAnnouncing = false;
  @override
  bool get isAnnouncing => _isAnnouncing;

  @override
  bool shouldAnnounce(Duration time) {
    if (isAnnouncing) return false;
    return isAboutTime(time, target);
  }

  @override
  Future<bool> announceSafely(Duration time, TaskModel payload) async {
    if (shouldAnnounce(time)) {
      if (kIsWeb || Platform.isIOS || Platform.isAndroid) {
        await _flutterTts.speak(payload.title);
      }
      return true;
    }
    return false;
  }

  _initFlutterTts() async {
    _flutterTts.setStartHandler(() => _isAnnouncing = true);
    _flutterTts.setCompletionHandler(() => _isAnnouncing = false);
    _flutterTts.setCancelHandler(() => _isAnnouncing = false);

    if (kIsWeb || Platform.isIOS) {
      await _flutterTts.awaitSpeakCompletion(true);
      await _flutterTts.setSpeechRate(0.5);
      await _flutterTts.setVolume(0.5);
      await _flutterTts.setPitch(1.5);
    }

    if (Platform.isIOS) {
      await _flutterTts.setSharedInstance(true);
      await _flutterTts.setIosAudioCategory(
          IosTextToSpeechAudioCategory.ambient,
          [
            IosTextToSpeechAudioCategoryOptions.allowBluetooth,
            IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
            IosTextToSpeechAudioCategoryOptions.mixWithOthers
          ],
          IosTextToSpeechAudioMode.voicePrompt);
      await _flutterTts.setVoice({'name': 'Siri', 'locale': 'en-US'});
    }
  }

  @override
  reset() async {
    if (kIsWeb || Platform.isIOS) {
      await _flutterTts.stop();
    }
  }
}
