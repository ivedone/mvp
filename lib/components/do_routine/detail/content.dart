import 'package:flutter/material.dart';
import 'package:mvp/components/do_routine/detail/alternate_video.dart';
import 'package:mvp/components/do_routine/detail/video.dart';
import 'package:provider/provider.dart';

import 'package:mvp/models/do_routine.dart';
import 'package:mvp/models/task.dart';

class DetailContent extends StatelessWidget {
  const DetailContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<DoRoutineModel, TaskModel?>(
        selector: (_, DoRoutineModel model) => model.currentTask,
        builder: (_, TaskModel? task, __) {
          if (task == null) {
            return const Center(child: Text('No task selected'));
          }
          if (task.hasVideo) {
            return DetailVideo(task: task);
          } else {
            return DetailVideoAlternate(task: task);
          }
        });
  }
}
