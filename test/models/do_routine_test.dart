import 'package:flutter_test/flutter_test.dart';
import 'package:mvp/models/countdown.dart';
import 'package:mvp/models/do_routine.dart';
import 'package:mvp/models/routine.dart';
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

    test('.skipBack() shuld change tasks in doRoutine and countdown', () {
      doRoutine.selectTaskAtIndex(routine.length - 1);
      for (int i = routine.length - 1; i >= 0; i--) {
        expect(doRoutine.index, i);
        expect(countdown.task!, routine.atIndex(i));
        expect(doRoutine.currentTask!, routine.atIndex(i)!);
        doRoutine.skipBack();
      }
    });
  });
}
