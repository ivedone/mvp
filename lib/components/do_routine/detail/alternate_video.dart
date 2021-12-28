import 'package:flutter/material.dart';
import 'package:mvp/models/countdown.dart';

import 'package:mvp/models/task.dart';
import 'package:provider/provider.dart';

class DetailVideoAlternate extends StatelessWidget {
  final TaskModel task;
  const DetailVideoAlternate({
    Key? key,
    required this.task,
  }) : super(key: key);

  String getState(TaskModel task) {
    switch (task.type) {
      case TaskType.rest:
        return 'Take a break';
      case TaskType.work:
        return 'Go!';
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle stateStyle =
        Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white);
    final TextStyle remainingStyle =
        Theme.of(context).textTheme.headline2!.copyWith(color: Colors.white);
    final Color color = getTaskTheme(task.type).colorScheme.secondaryVariant;
    return Container(
        color: color,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Selector<CountdownModel, String>(
                      selector: (_, CountdownModel countdown) =>
                          countdown.remainingString,
                      builder: (_, String remaining, __) {
                        return Text(remaining, style: remainingStyle);
                      })),
              Center(child: Text(getState(task), style: stateStyle)),
            ]));
  }
}
