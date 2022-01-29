import 'package:flutter/material.dart';

import 'package:mvp/models/task.dart';

import 'animated.dart';
import 'static.dart';

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
        return StaticCountdownWidget(remaining: duration, percentDone: 0.0);
      case TaskState.active:
        return const AnimatedCountdownWidget();
      case TaskState.done:
        return const StaticCountdownWidget(
            remaining: Duration.zero, percentDone: 1.0);
    }
  }
}
