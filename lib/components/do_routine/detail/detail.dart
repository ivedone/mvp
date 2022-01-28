import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mvp/services/do_routine.dart';
import 'package:mvp/components/do_routine/progress/progress.dart';

import 'detail_content.dart';
import 'detail_controls.dart';

class DoRoutineDetailWidget extends StatefulWidget {
  const DoRoutineDetailWidget({Key? key}) : super(key: key);

  @override
  _DoRoutineDetailWidgetState createState() => _DoRoutineDetailWidgetState();
}

class _DoRoutineDetailWidgetState extends State<DoRoutineDetailWidget> {
  Timer? _timer;

  late bool _show;
  bool get show => _show;

  late final DoRoutineModel doRoutineMethods;
  late bool _isPaused;
  bool get isPaused => _isPaused;

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    doRoutineMethods = Provider.of<DoRoutineModel>(context, listen: false);
    _isPaused = doRoutineMethods.isPaused;
    _show = _isPaused;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final bool willPause = Provider.of<DoRoutineModel>(context).isPaused;
    final bool didPause = willPause && willPause != isPaused;
    final bool didPlay = !willPause && willPause != isPaused;
    setState(() {
      _isPaused = willPause;
      if (didPause) {
        cancelTimer();
        _show = true;
      } else if (didPlay) {
        hideInThreeSeconds();
      }
    });
  }

  cancelTimer() {
    _timer?.cancel();
  }

  hideInThreeSeconds() {
    cancelTimer();
    _timer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _show = false;
      });
    });
  }

  toggleShow() {
    setState(() {
      if (show) {
        cancelTimer();
      } else {
        if (!isPaused) {
          hideInThreeSeconds();
        }
      }
      _show = !show;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = 1 * MediaQuery.of(context).size.height / 3;
    return SizedBox(
      height: height,
      child: Column(
        children: [
          Expanded(
              child: Stack(children: [
            const DetailContentWidget(),
            _gestureDetector(ignoreMirrorsShow: true),
            _gestureDetector(
                ignoreMirrorsShow: false,
                child: AnimatedOpacity(
                  opacity: show ? 1 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: const DetailControlsWidget(),
                )),
          ])),
          const SizedBox(height: 3),
          const DoRoutineProgressIndicator(),
          const SizedBox(height: 3),
        ],
      ),
    );
  }

  Widget _gestureDetector({
    required bool ignoreMirrorsShow,
    Widget? child,
  }) {
    return IgnorePointer(
        ignoring: ignoreMirrorsShow ? show : !show,
        child: GestureDetector(
            onTap: toggleShow,
            onDoubleTap: () {},
            onDoubleTapDown: _handleDoubleTapDown,
            child: child));
  }

  _handleDoubleTapDown(TapDownDetails details) {
    final double width = context.size!.width;
    final double dx = details.localPosition.dx;
    final isLeft = (dx / width) < 0.5;
    if (isLeft) {
      doRoutineMethods.skipBack10Sec();
    } else {
      doRoutineMethods.skipForward10Sec();
    }
  }
}
