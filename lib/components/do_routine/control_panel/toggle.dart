import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mvp/services/do_routine.dart';

class ControlPanelToggleButton extends StatefulWidget {
  const ControlPanelToggleButton({Key? key}) : super(key: key);

  @override
  _ControlPanelToggleButtonState createState() =>
      _ControlPanelToggleButtonState();
}

class _ControlPanelToggleButtonState extends State<ControlPanelToggleButton>
    with SingleTickerProviderStateMixin {
  late final bool wasPausedOnInit;
  late bool wasPausedLastFrame;
  late final AnimationController _controller;
  late final void Function() toggle;

  @override
  void initState() {
    super.initState();
    DoRoutineModel doRoutine =
        Provider.of<DoRoutineModel>(context, listen: false);
    _controller = AnimationController(
        duration: const Duration(milliseconds: 150), vsync: this);
    toggle = doRoutine.toggle;
    wasPausedOnInit = doRoutine.isPaused;
    wasPausedLastFrame = wasPausedOnInit;
  }

  @override
  void didChangeDependencies() {
    DoRoutineModel doRoutine = Provider.of<DoRoutineModel>(context);
    if (doRoutine.isPaused != wasPausedLastFrame) {
      if (wasPausedOnInit) {
        if (doRoutine.isPaused) {
          _controller.reverse();
        } else {
          _controller.forward();
        }
      } else {
        if (doRoutine.isPaused) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
      }
      setState(() {
        wasPausedLastFrame = doRoutine.isPaused;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onPressed: toggle,
        icon: AnimatedIcon(
            icon: wasPausedOnInit
                ? AnimatedIcons.play_pause
                : AnimatedIcons.pause_play,
            progress: _controller));
  }
}
