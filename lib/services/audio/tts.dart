import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_tts/flutter_tts.dart';

Future<FlutterTts> initTts() async {
  final FlutterTts tts = FlutterTts();
  if (kIsWeb) {
    await tts.awaitSpeakCompletion(true);
  } else {
    if (Platform.isIOS) {
      await tts.setSharedInstance(true);
      await tts.setIosAudioCategory(
          IosTextToSpeechAudioCategory.ambient,
          [
            IosTextToSpeechAudioCategoryOptions.allowBluetooth,
            IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
            IosTextToSpeechAudioCategoryOptions.mixWithOthers
          ],
          IosTextToSpeechAudioMode.voicePrompt);
      await tts.setVoice({'name': 'Siri', 'locale': 'en-US'});
      await tts.setSpeechRate(0.5);
    }
  }
  return tts;
}
