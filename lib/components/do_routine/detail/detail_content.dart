import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mvp/services/do_routine.dart';
import 'package:mvp/models/task.dart';

import 'detail_video.dart';
import 'detail_alternate_text.dart';

class DetailContentWidget extends StatelessWidget {
  const DetailContentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<DoRoutine, Task?>(
        selector: (_, DoRoutine model) => model.currentTask,
        builder: (_, Task? task, __) {
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
