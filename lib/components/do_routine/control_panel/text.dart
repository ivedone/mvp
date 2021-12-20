import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mvp/models/do_routine.dart';

class ControlPanelText extends StatelessWidget {
  const ControlPanelText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.caption!;
    return Expanded(
        child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: Selector<DoRoutineModel, String>(
                          selector: (_, DoRoutineModel doRoutine) =>
                              doRoutine.currentTask!.title,
                          builder: (BuildContext context, String title, __) {
                            final Color color =
                                Theme.of(context).colorScheme.onBackground;
                            return Text(title,
                                style: textStyle.copyWith(color: color));
                          })),
                  Expanded(
                      child: Selector<DoRoutineModel, String>(
                          selector: (_, DoRoutineModel doRoutine) =>
                              doRoutine.routine!.creator.handle,
                          builder: (BuildContext context, String creator, __) {
                            return Text(creator, style: textStyle);
                          }))
                ])));
  }
}
