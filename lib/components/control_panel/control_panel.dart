import 'package:flutter/material.dart';
import 'package:mvp/components/control_panel/toggle.dart';
import 'package:provider/provider.dart';

import 'package:mvp/models/do_routine.dart';
import 'package:mvp/screens/do_routine.dart';

import 'text.dart';
import 'thumbnail.dart';

class ControlPanelWidget extends StatelessWidget {
  const ControlPanelWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hasRoutine = Provider.of<DoRoutineModel>(context).hasRoutine;
    if (!hasRoutine) return Container();

    return SizedBox(
        height: 50,
        child: GestureDetector(
            child: DecoratedBox(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryVariant),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const LinearProgressIndicator(
                          value: null,
                          color: Colors.white,
                          backgroundColor: Colors.black),
                      Divider(
                          height: 2,
                          color: Theme.of(context).colorScheme.primary),
                      Expanded(
                          child: Row(children: const [
                        ControlPanelThumbnail(),
                        ControlPanelText(),
                        ControlPanelToggleButton(),
                      ])),
                      Divider(
                          height: 2,
                          color: Theme.of(context).colorScheme.primary),
                    ])),
            onTap: () {
              showGeneralDialog(
                  context: context,
                  barrierDismissible: false,
                  barrierColor: Colors.transparent,
                  transitionDuration: const Duration(milliseconds: 250),
                  pageBuilder: (context, anim1, anim2) {
                    return Dismissible(
                        direction: DismissDirection.vertical,
                        key: const ValueKey('DoRoutineFullScreenModal'),
                        onDismissed: (_) => Navigator.of(context).pop(),
                        child: const DoRoutineFullScreenModal());
                  },
                  transitionBuilder: (context, anim1, anim2, child) {
                    return SlideTransition(
                        position: Tween(
                                begin: const Offset(0, 1),
                                end: const Offset(0, 0))
                            .animate(anim1),
                        child: child);
                  });
            }));
  }
}
