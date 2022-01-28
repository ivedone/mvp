import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mvp/services/audio_notifier/audio_notifier.dart';
import 'package:mvp/services/countdown.dart';
import 'package:mvp/services/do_routine.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('AudioNotifier', () {
    final CountdownModel countdown = CountdownModel();
    final DoRoutineModel doRoutine = DoRoutineModel(countdown: countdown);
    final AudioNotifier audioNotifier = AudioNotifier(doRoutine: doRoutine);

    setUp(() async {
      await Future.delayed(Duration.zero);
    });

    test('it should load', () {
      expect(audioNotifier.loading, false);
    });

    test('it should handle taps', () {
      expect(audioNotifier.all, true);
      audioNotifier.toggle();
      expect(audioNotifier.muted, true);
      audioNotifier.toggle();
      expect(audioNotifier.all, true);
    });
  });
}
