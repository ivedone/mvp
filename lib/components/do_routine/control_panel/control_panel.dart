import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mvp/screens/do_routine.dart';
import 'package:mvp/models/do_routine.dart';
import 'package:mvp/components/do_routine/progress/progress.dart';

import 'thumbnail.dart';
import 'text.dart';
import 'toggle.dart';

class ControlPanelWidget extends StatelessWidget {
  const ControlPanelWidget({Key? key}) : super(key: key);

  Widget _divider(BuildContext context) =>
      Divider(height: 2, color: Theme.of(context).colorScheme.primary);

  @override
  Widget build(BuildContext context) {
    final bool shouldNotRender =
        Provider.of<DoRoutineModel>(context).shouldNotRender;
    if (shouldNotRender) return Container();

    return SizedBox(
        height: 50,
        child: GestureDetector(
            child: DecoratedBox(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryVariant),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const DoRoutineProgressIndicator(),
                      _divider(context),
                      Expanded(
                          child: Row(children: const [
                        ControlPanelThumbnail(),
                        ControlPanelText(),
                        ControlPanelToggleButton(),
                      ])),
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
