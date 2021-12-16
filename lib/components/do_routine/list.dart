import 'package:flutter/material.dart';
import 'package:mvp/components/do_routine/task.dart';
import 'package:mvp/models/do_routine.dart';
import 'package:mvp/models/routine.dart';
import 'package:provider/provider.dart';

class DoRoutineListWidget extends StatelessWidget {
  const DoRoutineListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<DoRoutineModel, RoutineModel>(
      selector: (_, DoRoutineModel doRoutine) => doRoutine.routine!,
      builder: (_, RoutineModel routine, __) => Selector<DoRoutineModel, int>(
          selector: (_, DoRoutineModel doRoutine) => doRoutine.index,
          builder: (BuildContext context, int currentIndex, __) {
            return ListView.builder(
              itemCount: routine.length,
              itemBuilder: (BuildContext context, int taskIndex) {
                return TaskWidget(
                    taskIndex: taskIndex, task: routine.atIndex(taskIndex)!);
              },
            );
          }),
    );
  }
}
