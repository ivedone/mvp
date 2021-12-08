import 'package:flutter/material.dart';
import 'package:mvp/models/task.dart';

class TaskWidget extends StatelessWidget {
  final TaskModel task;
  const TaskWidget({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Center(child: CircularProgressIndicator()),
      title: Text(task.title),
    );
  }
}
