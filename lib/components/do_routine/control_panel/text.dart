import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mvp/services/do_routine.dart';

class ControlPanelText extends StatelessWidget {
  const ControlPanelText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.caption!;
    return Expanded(
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Selector<DoRoutine, String>(
                          selector: (_, DoRoutine doRoutine) =>
                              doRoutine.currentTask!.title,
                          builder: (BuildContext context, String title, __) {
                            final Color color =
                                Theme.of(context).colorScheme.onBackground;
                            return Text(title,
                                style: textStyle.copyWith(color: color));
                          })),
                  Expanded(
                      child: Selector<DoRoutine, String>(
                          selector: (_, DoRoutine doRoutine) =>
                              doRoutine.routine!.creator.handle,
                          builder: (BuildContext context, String creator, __) {
                            return Text(creator, style: textStyle);
                          }))
                ])));
  }
}
