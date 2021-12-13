import 'package:flutter/material.dart';
import 'package:mvp/components/do_routine/countdown.dart/animated.dart';
import 'package:mvp/components/do_routine/countdown.dart/static.dart';
import 'package:mvp/models/task.dart';

class CountdownWidget extends StatelessWidget {
  final Duration duration;
  final TaskState taskState;
  const CountdownWidget({
    Key? key,
    required this.duration,
    required this.taskState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (taskState) {
      case TaskState.idle:
        return StaticCountdownWidget(
          remaining: duration,
          percentDone: 1.0,
        );
      case TaskState.active:
        return const AnimatedCountdownWidget();
      case TaskState.done:
        return const StaticCountdownWidget(
          remaining: Duration.zero,
          percentDone: 0.0,
        );
    }
  }
}
