import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mvp/models/do_routine.dart';
import 'package:mvp/models/task.dart';

import 'detail_video.dart';
import 'detail_alternate_text.dart';

class DetailContent extends StatelessWidget {
  const DetailContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<DoRoutineModel, TaskModel?>(
        selector: (_, DoRoutineModel model) => model.currentTask,
        builder: (_, TaskModel? task, __) {
          /// TODO: resolve no task behavior such as completion and no routine selected
          if (task == null) {
            return const Center(child: Text('No task selected'));
          }
          if (task.hasVideo) {
            return DetailVideo(task: task);
          } else {
            return DetailAlternateText(task: task);
          }
        });
  }
}
