import 'package:flutter/material.dart';
import 'package:mvp/models/task.dart';
import 'package:mvp/util/clock_format.dart';
import 'countdown.dart/static.dart';

class TaskWidget extends StatelessWidget {
  final TaskModel task;
  const TaskWidget({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: StaticCountdownWidget(
            remaining: toMinutesAndSeconds(task.duration), percentDone: 1.0),
        title: Text(task.title),
        subtitle: Text(task.description ?? ''),
      ),
    );
  }
}
