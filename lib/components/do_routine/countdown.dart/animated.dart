import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mvp/services/countdown.dart';

class AnimatedCountdownWidget extends StatelessWidget {
  const AnimatedCountdownWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Stack(
        children: [
          Center(
              child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primaryVariant,
                  ),
                  child: Selector<Countdown, double>(
                      selector: (_, Countdown countdown) =>
                          countdown.percentDone,
                      builder: (_, percentDone, __) =>
                          CircularProgressIndicator(
                              strokeWidth: 5.0,
                              value: percentDone,
                              semanticsLabel: 'Task progress',
                              color: Theme.of(context).colorScheme.secondary,
                              backgroundColor: Colors.transparent)))),
          Center(
              child: Selector<Countdown, String>(
                  selector: (_, Countdown countdown) =>
                      countdown.remainingString,
                  builder: (_, remaining, __) => Text(remaining,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondary)))),
        ],
      ),
    );
  }
}
