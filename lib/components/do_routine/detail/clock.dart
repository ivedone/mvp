import 'package:flutter/material.dart';
import 'package:mvp/components/do_routine/progress/progress.dart';

class DoRoutineDetailClock extends StatelessWidget {
  const DoRoutineDetailClock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('XX:XX'),
                    Text('XX:XX'),
                  ])),
          const DoRoutineProgressIndicator(),
        ],
      ),
    );
  }
}
