import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mvp/services/do_routine.dart';

class ToggleButton extends StatefulWidget {
  final double? size;
  final bool hideSplash;
  const ToggleButton({Key? key, this.size, this.hideSplash = true})
      : super(key: key);

  @override
  _ToggleButtonState createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton>
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
        highlightColor: widget.hideSplash ? Colors.transparent : null,
        splashColor: widget.hideSplash ? Colors.transparent : null,
        onPressed: toggle,
        icon: AnimatedIcon(
            size: widget.size,
            icon: wasPausedOnInit
                ? AnimatedIcons.play_pause
                : AnimatedIcons.pause_play,
            progress: _controller));
  }
}
