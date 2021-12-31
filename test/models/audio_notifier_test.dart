import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mvp/models/audio_notifier.dart';
import 'package:mvp/models/countdown.dart';
import 'package:mvp/models/do_routine.dart';
import 'package:mvp/util/seed.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('AudioNotifier', () {
    final CountdownModel countdown = CountdownModel();
    final DoRoutineModel doRoutine = DoRoutineModel(countdown: countdown)
      ..selectRoutine(SeedRoutines.AbsInTwoWeeks);
    final AudioNotifier audioNotifier =
        AudioNotifier(doRoutine: doRoutine, countdown: countdown);

    tearDown(() {
      doRoutine.stop();
      doRoutine.restart();
    });

    test('it loads without failing', () {
      expect(audioNotifier.shouldAnnounceTask, false);
    });
  });
}
