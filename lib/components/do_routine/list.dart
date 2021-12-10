import 'package:flutter/material.dart';
import 'package:mvp/components/do_routine/task.dart';
import 'package:mvp/models/do_routine.dart';
import 'package:mvp/models/routine.dart';
import 'package:mvp/models/task.dart';
import 'package:provider/provider.dart';

class DoRoutineListWidget extends StatelessWidget {
  const DoRoutineListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<DoRoutineModel, RoutineModel>(
        selector: (_, DoRoutineModel doRoutine) => doRoutine.routine!,
        builder: (BuildContext context, RoutineModel routine, _) {
          return ListView.builder(
            itemCount: routine.length,
            itemBuilder: (BuildContext context, int index) {
              final TaskModel task = routine.tasks[index];
              final String valueKey = <dynamic>[task.id, task.title].join('#');
              return TaskWidget(
                key: ValueKey(valueKey),
                task: task,
                index: index,
              );
            },
          );
        });
  }
}
