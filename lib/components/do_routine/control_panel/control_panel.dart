import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mvp/screens/do_routine.dart';
import 'package:mvp/services/do_routine.dart';
import 'package:mvp/components/do_routine/progress/progress.dart';
import 'package:mvp/components/do_routine/toggle_button.dart';

import 'thumbnail.dart';
import 'text.dart';

class ControlPanelWidget extends StatelessWidget {
  const ControlPanelWidget({Key? key}) : super(key: key);

  Widget _divider(BuildContext context) => Material(
      color: Theme.of(context).colorScheme.primary,
      child: const Divider(height: 2));

  @override
  Widget build(BuildContext context) {
    final bool shouldNotRender =
        Provider.of<DoRoutine>(context).shouldNotRender;
    if (shouldNotRender) return Container();

    return SizedBox(
        height: 60,
        child: GestureDetector(
            child: DecoratedBox(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryVariant),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                          child: Row(children: const [
                        ControlPanelThumbnail(),
                        ControlPanelText(),
                        ToggleButton(size: 30),
                      ])),
                      _divider(context),
                      const DoRoutineProgressIndicator(),
                      _divider(context),
                    ])),
            onTap: () {
              showGeneralDialog(
                  context: context,
                  barrierDismissible: false,
                  barrierColor: Colors.transparent,
                  barrierLabel: 'DoRoutineModal',
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
