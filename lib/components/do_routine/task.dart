import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mvp/models/do_routine.dart';
import 'package:mvp/components/do_routine/countdown.dart/countdown.dart';
import 'package:mvp/models/task.dart';

class TaskWidget extends StatelessWidget {
  final int taskIndex;
  final TaskModel task;
  const TaskWidget({
    Key? key,
    required this.taskIndex,
    required this.task,
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
    final DoRoutineModel doRoutine =
        Provider.of<DoRoutineModel>(context, listen: false);
    final DoRoutineModel Function(int) selectTaskAtIndex =
        doRoutine.selectTaskAtIndex;
    final ThemeData theme = getTaskTheme(task.type);
    return Theme(
        data: theme,
        child: Selector<DoRoutineModel, TaskState>(
            selector: (_, DoRoutineModel doRoutine) =>
                getTaskState(taskIndex, doRoutine.index),
            builder: (_, TaskState taskState, __) {
              return InkWell(
                  onTap: () => selectTaskAtIndex(taskIndex),
                  child: Selector<DoRoutineModel, TaskState>(
                      selector: (_, DoRoutineModel doRoutine) {
                    final int currentIndex = doRoutine.index;
                    return getTaskState(taskIndex, currentIndex);
                  }, builder: (_, TaskState taskState, __) {
                    return ListTile(
                        leading: CountdownWidget(
                            duration: task.duration, taskState: taskState),
                        title: Text(task.title,
                            style: _getTitleStyle(taskState, theme)),
                        subtitle: Text(task.description ?? ''));
                  }));
            }));
  }
}
