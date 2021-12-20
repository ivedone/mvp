import 'package:flutter/material.dart';
import 'package:mvp/screens/do_routine.dart';

class ControlPanelWidget extends StatelessWidget {
  const ControlPanelWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        child: GestureDetector(
            child: DecoratedBox(
                child: const Center(child: Text('ControlPanelWidget')),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary)),
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
