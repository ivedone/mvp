import 'package:flutter/material.dart';
import 'package:mvp/components/do_routine/task.dart';
import 'package:mvp/models/routine.dart';
import 'package:mvp/models/task.dart';

class DoRoutineListWidget extends StatelessWidget {
  final RoutineModel routine;
  const DoRoutineListWidget({
    Key? key,
    required this.routine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: routine.length,
      itemBuilder: (BuildContext context, int index) {
        final TaskModel task = routine.tasks[index];
        final String valueKey = <dynamic>[task.id, task.title].join('#');
        return TaskWidget(key: ValueKey(valueKey), task: task);
      },
    );
  }
}
