import 'package:flutter/material.dart';

import 'clock.dart';
import 'controls.dart';

class DoRoutineDetailWidget extends StatelessWidget {
  const DoRoutineDetailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 3;
    return SizedBox(
        height: height,
        child: Container(
            // color: Theme.of(context).colorScheme.primaryVariant,
            color: Colors.transparent,
            child: Stack(children: [
              DoRoutineDetailClock(),
              DoRoutineDetailControls(),
            ])));
  }
}
