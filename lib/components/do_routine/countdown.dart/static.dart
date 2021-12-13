import 'package:flutter/material.dart';
import 'package:mvp/util/clock_format.dart';

class StaticCountdownWidget extends StatelessWidget {
  final Duration remaining;
  final double percentDone;

  const StaticCountdownWidget({
    Key? key,
    required this.remaining,
    required this.percentDone,
  }) : super(key: key);

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
                child: CircularProgressIndicator(
                    strokeWidth: 5.0,
                    value: percentDone,
                    semanticsLabel: 'Task progress',
                    color: Theme.of(context).colorScheme.secondary,
                    backgroundColor: Colors.transparent)),
          ),
          Center(
              child: Text(toMinutesAndSeconds(remaining),
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary)))
        ],
      ),
    );
  }
}
