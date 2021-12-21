import 'package:flutter/material.dart';
import 'package:mvp/components/do_routine/progress/progress.dart';

class DoRoutineDetailWidget extends StatelessWidget {
  const DoRoutineDetailWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 3;
    return SizedBox(
        height: height,
        child: Container(
            color: Theme.of(context).colorScheme.primaryVariant,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                      height: 20, child: Container(color: Colors.grey[700])),
                  Expanded(child: Center(child: Text('DoRoutineDetailWidget'))),
                  DoRoutineProgressIndicator(),
                ])));
  }
}
