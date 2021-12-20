import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mvp/models/do_routine.dart';
import 'package:mvp/models/task.dart';
import 'package:mvp/components/progress/chunk/static_chunk.dart';

class ProgressChunk extends StatelessWidget {
  final int taskIndex;
  const ProgressChunk({
    Key? key,
    required this.taskIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<DoRoutineModel, TaskState>(
      selector: (_, DoRoutineModel doRoutine) {
        final int currentIndex = doRoutine.index;
        return getTaskState(taskIndex, currentIndex);
      },
      builder: (_, TaskState taskState, __) {
        switch (taskState) {
          case TaskState.idle:
            return const StaticProgressChunk(percentDone: 0.0);
          case TaskState.active:
            return const StaticProgressChunk(percentDone: 0.3);
          case TaskState.done:
            return const StaticProgressChunk(percentDone: 1.0);
        }
      },
    );
  }
}
