import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mvp/models/audio_notifier/announcer/announcer.dart';
import 'package:mvp/models/audio_notifier/announcer/task_announcer.dart';
import 'package:mvp/util/seed.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  group('Announcer', () {
    group('TaskAnnouncer', () {
      final Announcer taskAnnouncer = TaskAnnouncer();

      tearDown(() async {
        await taskAnnouncer.reset();
      });
      test('it should know when to announce', () {
        final bool shouldAnnounce = taskAnnouncer.shouldAnnounce(Duration.zero);
        expect(shouldAnnounce, true);
      });

      test('it should announce', () async {
        final bool announced = await taskAnnouncer.announceSafely(
            Duration.zero, SeedTasks.DeadBugs());
        expect(announced, true);
      });
    });
  });
}
