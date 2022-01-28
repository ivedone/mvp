import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mvp/services/do_routine.dart';
import 'package:mvp/models/task.dart';

class ControlPanelThumbnail extends StatelessWidget {
  const ControlPanelThumbnail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<DoRoutineModel, TaskModel>(
      selector: (_, DoRoutineModel model) => model.currentTask!,
      builder: (_, TaskModel task, __) {
        return AspectRatio(
            aspectRatio: 1 / 1,
            child: DecoratedBox(
                decoration: BoxDecoration(
                    color: getTaskTheme(task.type).colorScheme.secondary)));
      },
    );
  }
}
