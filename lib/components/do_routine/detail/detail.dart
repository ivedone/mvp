import 'package:flutter/material.dart';

import 'text.dart';
import 'controls.dart';

class DoRoutineDetailWidget extends StatelessWidget {
  const DoRoutineDetailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = 1 * MediaQuery.of(context).size.height / 3;
    return SizedBox(
        height: height,
        child: Container(
            color: Colors.transparent,
            child: Stack(children: const [
              DoRoutineDetailText(),
              DoRoutineDetailControls(),
            ])));
  }
}
