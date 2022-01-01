import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mvp/models/audio_notifier/audio_notifier.dart';
import 'package:mvp/models/countdown.dart';
import 'package:mvp/models/do_routine.dart';

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
      audioNotifier.handleTap();
      expect(audioNotifier.muted, true);
      audioNotifier.handleTap();
      expect(audioNotifier.all, true);
    });
  });
}
