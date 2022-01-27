import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_tts/flutter_tts.dart';

import 'package:mvp/models/task.dart';

import 'announcer.dart';

class TaskAnnouncer extends Announcer<TaskModel> {
  final FlutterTts _flutterTts = FlutterTts();

  TaskAnnouncer() : super(target: const Duration(milliseconds: 0));

  bool _isAnnouncing = false;
  @override
  bool get isAnnouncing => _isAnnouncing;

  @override
  bool shouldAnnounce(Duration time) {
    if (isAnnouncing) return false;
    return isAboutTime(time, target);
  }

  String _sentence(TaskModel task) {
    final List<String> sentence = [task.title, 'for'];
    final int minutes = task.duration.inMinutes;
    if (minutes > 0) {
      sentence.add(minutes.toString());
      if (minutes == 1) {
        sentence.add('minute');
      } else {
        sentence.add('minutes');
      }
    }

    final int seconds = task.duration.inSeconds - 60 * minutes;
    if (seconds > 0) {
      if (minutes > 0) sentence.add('and');
      sentence.add(seconds.toString());
      if (seconds == 1) {
        sentence.add('second');
      } else {
        sentence.add('seconds');
      }
    }

    return sentence.join(' ');
  }

  @override
  Future<bool> announceSafely(Duration time, TaskModel payload) async {
    if (shouldAnnounce(time)) {
      reset();
      _isAnnouncing = true;
      if (kIsWeb || Platform.isIOS || Platform.isAndroid) {
        await _flutterTts.speak(_sentence(payload));
      }
      _isAnnouncing = false;
      return true;
    }
    return false;
  }

  @override
  init() async {
    if (kIsWeb) {
      await _flutterTts.awaitSpeakCompletion(true);
      await _flutterTts.setSpeechRate(0.5);
      await _flutterTts.setVolume(0.5);
      await _flutterTts.setPitch(1.2);
    } else {
      if (Platform.isIOS) {
        await _flutterTts.awaitSpeakCompletion(true);
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
        await _flutterTts.setSpeechRate(0.45);
        await _flutterTts.setVolume(1.0);
        await _flutterTts.setPitch(1.0);
      }
    }
  }

  @override
  reset() async {
    if (kIsWeb || Platform.isIOS) {
      await _flutterTts.stop();
    }
  }
}
