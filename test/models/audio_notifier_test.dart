import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mvp/models/audio_notifier/audio_notifier.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('AudioNotifier', () {
    final AudioNotifier audioNotifier = AudioNotifier();

    setUp(() async {
      await Future.delayed(Duration.zero);
    });

    test('it should load', () {
      expect(audioNotifier.loading, false);
    });

    test('it should handle taps', () {
      expect(audioNotifier.all, true);
      audioNotifier.handleTap();
      expect(audioNotifier.alertsOnly, true);
      audioNotifier.handleTap();
      expect(audioNotifier.muted, true);
      audioNotifier.handleTap();
      expect(audioNotifier.all, true);
    });
  });
}
