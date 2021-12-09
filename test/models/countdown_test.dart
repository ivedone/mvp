import 'package:flutter_test/flutter_test.dart';
import 'package:mvp/models/countdown.dart';
import 'package:mvp/models/task.dart';
import 'package:mvp/util/seed.dart';

void main() {
  group('CountdownModel', () {
    final CountdownModel countdown = CountdownModel();
    final TaskModel task = SeedTasks.DeadBugs();

    setUp(() {
      countdown.selectTask(task);
    });

    tearDown(() {
      countdown.clearTask();
    });

    test('.complete() finishes the countdown', () {
      expect(countdown.isDone, false);
      countdown.complete();
      expect(countdown.isDone, true);
      expect(countdown.remaining, Duration.zero);
    });
  });
}
