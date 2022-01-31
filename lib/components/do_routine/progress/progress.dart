import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mvp/services/do_routine.dart';
import 'package:mvp/models/routine.dart';
import 'package:mvp/models/task.dart';

import 'chunk/chunk.dart';

class DoRoutineProgressIndicator extends StatelessWidget {
  const DoRoutineProgressIndicator({
    Key? key,
  }) : super(key: key);

  Widget _spacer() => const SizedBox(width: 3);
  final double _height = 5.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      child: Selector<DoRoutine, RoutineModel>(
        selector: (_, DoRoutine doRoutine) => doRoutine.routine!,
        builder: (_, RoutineModel routine, __) {
          List<Widget> children = [];
          for (int i = 0; i < routine.length; i++) {
            if (i > 0) children.add(_spacer());
            final TaskModel task = routine.atIndex(i)!;
            final Widget chunk = Expanded(
                flex: task.duration.inSeconds,
                child: Theme(
                    data: getTaskTheme(task.type),
                    child: ProgressChunk(taskIndex: i)));
            children.add(chunk);
          }
          return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children);
        },
      ),
    );
  }
}
