import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:audioplayers/audioplayers.dart';

import 'package:mvp/models/audio_notifier/announcer/announcer.dart';

class CountdownAnnouncer extends Announcer {
  late final AudioCache? _audioCache;
  CountdownAnnouncer() : super(target: const Duration(seconds: 4)) {
    _initAudioCache();
  }

  bool _isAnnouncing = false;
  @override
  bool get isAnnouncing => _isAnnouncing;

  @override
  bool shouldAnnounce(Duration time) =>
      !isAnnouncing && isAboutTime(time, target);

  @override
  Future<bool> announceSafely(Duration time, payload) async {
    if (shouldAnnounce(time)) {
      _isAnnouncing = true;
      if (!kIsWeb && Platform.isIOS) {
        await _audioCache?.play('countdown.mp3', volume: 0.5);
      }
      _isAnnouncing = false;
      return true;
    }
    return false;
  }

  @override
  Future<void> reset() async {}

  _initAudioCache() async {
    if (kIsWeb) {
    } else {
      if (Platform.isIOS) {
        _audioCache = AudioCache(prefix: 'assets/audio/');
        await _audioCache?.load('countdown.mp3');
      }
    }
  }
}
