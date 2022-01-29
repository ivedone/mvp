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
  Timer? _showControlsTimer;

  late bool _showControls;
  bool get showControls => _showControls;

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
    _showControls = _isPaused;
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
        _showControls = true;
      } else if (didPlay) {
        hideInThreeSeconds();
      }
    });
  }

  cancelTimer() {
    _showControlsTimer?.cancel();
  }

  hideInThreeSeconds() {
    cancelTimer();
    _showControlsTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _showControls = false;
      });
    });
  }

  hide() {
    setState(() {
      _showControls = false;
    });
  }

  toggleShow() {
    setState(() {
      if (showControls) {
        cancelTimer();
      } else {
        if (!isPaused) {
          hideInThreeSeconds();
        }
      }
      _showControls = !showControls;
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
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Expanded(
                  child: Center(
                      child: AnimatedOpacity(
                          opacity: showSkip10SecBack ? 1 : 0,
                          duration: const Duration(milliseconds: 200),
                          child: _skip10Sec(false)))),
              Expanded(
                  child: Center(
                      child: AnimatedOpacity(
                          opacity: showSkip10SecForwards ? 1 : 0,
                          duration: const Duration(milliseconds: 200),
                          child: _skip10Sec(true)))),
            ]),
            _gestureDetector(ignoreMirrorsShow: true),
            _gestureDetector(
                ignoreMirrorsShow: false,
                child: AnimatedOpacity(
                  opacity: showControls ? 1 : 0,
                  duration: const Duration(milliseconds: 300),
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
        ignoring: ignoreMirrorsShow ? showControls : !showControls,
        child: GestureDetector(
            onTap: toggleShow,
            onDoubleTap: () {},
            onDoubleTapDown: _handleDoubleTapDown,
            child: child));
  }

  _handleDoubleTapDown(TapDownDetails details) {
    hide();
    final double width = context.size!.width;
    final double dx = details.localPosition.dx;
    final forwards = (dx / width) > 0.5;
    _showSkip10SecAndHide(forwards);
    if (forwards) {
      doRoutineMethods.skipForward10Sec();
    } else {
      doRoutineMethods.skipBack10Sec();
    }
  }

  _skip10Sec(bool forwards) {
    return Center(
        child: SizedBox(
            width: 150,
            height: 150,
            child: Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(0, 0, 0, 0.5)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(forwards ? Icons.fast_forward : Icons.fast_rewind),
                      const Text('10 sec'),
                    ]))));
  }

  Timer? _skip10SecForwardsTimer;
  bool _showSkip10SecForwards = false;
  bool get showSkip10SecForwards => _showSkip10SecForwards;

  Timer? _skip10SecBackTimer;
  bool _showSkip10SecBack = false;
  bool get showSkip10SecBack => _showSkip10SecBack;

  _clearSkip10SecTimer(bool forwards) {
    if (forwards) {
      _skip10SecForwardsTimer?.cancel();
    } else {
      _skip10SecBackTimer?.cancel();
    }
  }

  _showSkip10SecAndHide(bool forwards) {
    _clearSkip10SecTimer(forwards);
    setState(() {
      if (forwards) {
        _showSkip10SecForwards = true;
      } else {
        _showSkip10SecBack = true;
      }
    });

    final hide = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        if (forwards) {
          _showSkip10SecForwards = false;
        } else {
          _showSkip10SecBack = false;
        }
      });
    });

    if (forwards) {
      _skip10SecForwardsTimer = hide;
    } else {
      _skip10SecBackTimer = hide;
    }
  }
}
