import 'package:flutter_test/flutter_test.dart';
import 'package:mvp/services/countdown.dart';
import 'package:mvp/models/task.dart';
import 'package:mvp/util/seed.dart';

void main() {
  group('Countdown', () {
    final Countdown countdown = Countdown();
    final TaskModel task = SeedTasks.DeadBugs();

    setUp(() {
      countdown.selectTask(task);
    });

    tearDown(() {
      countdown.clearTask();
    });

    test('.start() increases elapsed', () async {
      countdown.start();
      await Future.delayed(const Duration(seconds: 1), () {
        expect(countdown.elapsed.inMilliseconds, greaterThan(0));
      });
    });

    test('.complete() finishes the countdown', () {
      expect(countdown.isDone, false);
      countdown.complete();
      expect(countdown.isDone, true);
      expect(countdown.remaining, Duration.zero);
    });
  });
}
