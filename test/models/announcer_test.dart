import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mvp/models/audio_notifier/announcer/announcer.dart';
import 'package:mvp/models/audio_notifier/announcer/countdown_announcer.dart';
import 'package:mvp/models/audio_notifier/announcer/task_announcer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  group('Announcer', () {
    group('TaskAnnouncer', () {
      final Announcer taskAnnouncer = TaskAnnouncer();

      tearDown(() async {
        await taskAnnouncer.reset();
      });
      test('it should know when to announce', () {
        final bool shouldAnnounce =
            taskAnnouncer.shouldAnnounce(taskAnnouncer.target);
        expect(shouldAnnounce, true);
      });
    });

    group('CountdownAnnouncer', () {
      final Announcer countdownAnnouncer = CountdownAnnouncer();
      test('it should know when to announce', () {
        final bool shouldAnnounce =
            countdownAnnouncer.shouldAnnounce(countdownAnnouncer.target);
        expect(shouldAnnounce, true);
      });
    });
  });
}
