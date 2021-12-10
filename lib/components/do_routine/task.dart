import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mvp/models/do_routine.dart';
import 'package:mvp/components/do_routine/countdown.dart/countdown.dart';
import 'package:mvp/models/task.dart';

class TaskWidget extends StatelessWidget {
  final TaskModel task;
  final int index;
  const TaskWidget({
    Key? key,
    required this.task,
    required this.index,
  }) : super(key: key);

  TextStyle _getTitleStyle(TaskState taskState, ThemeData theme) {
    if (taskState == TaskState.active) {
      return TextStyle(color: theme.colorScheme.secondary);
    } else {
      return const TextStyle();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = getTaskTheme(task.type);
    final DoRoutineModel Function(int) selectTaskAtIndex =
        Provider.of<DoRoutineModel>(context, listen: false).selectTaskAtIndex;
    return Theme(
      data: theme,
      child: InkWell(
        onTap: () => selectTaskAtIndex(index),
        child: Selector<DoRoutineModel, TaskState>(
            selector: (_, DoRoutineModel doRoutine) {
          final int currentIndex = doRoutine.index;
          return getTaskState(index, currentIndex);
        }, builder: (_, TaskState taskState, __) {
          return ListTile(
            leading: CountdownWidget(
              duration: task.duration,
              taskState: taskState,
            ),
            title: Text(
              task.title,
              style: _getTitleStyle(taskState, theme),
            ),
            subtitle: Text(task.description ?? ''),
          );
        }),
      ),
    );
  }
}
