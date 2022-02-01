import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mvp/services/countdown.dart';
import 'package:mvp/models/task.dart';

class DetailAlternateText extends StatelessWidget {
  final Task task;
  const DetailAlternateText({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle stateStyle =
        Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white);
    final TextStyle remainingStyle =
        Theme.of(context).textTheme.headline2!.copyWith(color: Colors.white);
    final Color color = getTaskTheme(task.type).colorScheme.secondaryVariant;
    return Material(
        color: color,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Selector<Countdown, String>(
                      selector: (_, Countdown countdown) =>
                          countdown.remainingString,
                      builder: (_, String remaining, __) {
                        return Text(remaining, style: remainingStyle);
                      })),
              Center(child: Text(task.title, style: stateStyle)),
            ]));
  }
}
