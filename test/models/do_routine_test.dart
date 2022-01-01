import 'package:flutter_test/flutter_test.dart';
import 'package:mvp/models/countdown.dart';
import 'package:mvp/models/do_routine.dart';
import 'package:mvp/models/routine.dart';
import 'package:mvp/models/task.dart';
import 'package:mvp/util/seed.dart';

void main() {
  group('DoRoutineModel', () {
    final CountdownModel countdown = CountdownModel();
    final DoRoutineModel doRoutine = DoRoutineModel(countdown: countdown);
    final RoutineModel routine = SeedRoutines.AbsInTwoWeeks;

    setUp(() {
      doRoutine.selectRoutine(routine);
    });

    tearDown(() {
      doRoutine.clearRoutine();
    });
    test('.skipForward() should change tasks in doRoutine and countdown', () {
      for (int i = 0; i < routine.length; i++) {
        expect(doRoutine.index, i);
        expect(countdown.task!, routine.atIndex(i)!);
        expect(doRoutine.currentTask!, routine.atIndex(i)!);
        doRoutine.skipForward();
      }
      expect(doRoutine.isDone, true);
    });

    test('.skipBack() should change tasks in doRoutine and countdown', () {
      doRoutine.selectTaskAtIndex(routine.length - 1, forceDontStart: true);
      for (int i = routine.length - 1; i >= 0; i--) {
        expect(doRoutine.index, i);
        expect(countdown.task!, routine.atIndex(i));
        expect(doRoutine.currentTask!, routine.atIndex(i)!);
        doRoutine.skipBack();
      }
    });

    test('.skipForward10Sec() should skip exactly 5 seconds', () {
      final TaskModel task = routine.atIndex(0)!;
      final startElapsed = task.duration - const Duration(seconds: 2);
      doRoutine.selectTaskAtIndex(0,
          startElapsed: startElapsed, forceDontStart: true);
      doRoutine.skipForward10Sec();
      const int expected = 3;
      expect(countdown.elapsed.inSeconds, expected);
    });

    test('.skipForward10Sec() can complete DoRoutineModel', () {
      final int lastIndex = routine.length - 1;
      final TaskModel lastTask = routine.atIndex(lastIndex)!;
      final startElapsed = lastTask.duration - const Duration(seconds: 2);
      doRoutine.selectTaskAtIndex(lastIndex,
          startElapsed: startElapsed, forceDontStart: true);
      doRoutine.skipForward10Sec();
      expect(doRoutine.hasTask, false);
    });

    test('.skipBack10Sec() should skip exactly 5 seconds', () {
      const startElapsed = Duration(seconds: 2);
      final bool hasTaskAtIndexOne = doRoutine.atIndex(1) != null;
      expect(hasTaskAtIndexOne, true);
      if (hasTaskAtIndexOne) {
        doRoutine.selectTaskAtIndex(1,
            startElapsed: startElapsed, forceDontStart: true);
        doRoutine.skipBack10Sec();
        int expected = routine.atIndex(0)!.duration.inSeconds - 3;
        expect(countdown.elapsed.inSeconds, expected);
      }
    });
  });
}
