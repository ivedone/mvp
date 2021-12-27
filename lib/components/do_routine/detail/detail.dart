import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mvp/models/do_routine.dart';
import 'package:provider/provider.dart';

import 'text.dart';
import 'controls.dart';

class DoRoutineDetailWidget extends StatefulWidget {
  const DoRoutineDetailWidget({Key? key}) : super(key: key);

  @override
  _DoRoutineDetailWidgetState createState() => _DoRoutineDetailWidgetState();
}

class _DoRoutineDetailWidgetState extends State<DoRoutineDetailWidget> {
  Timer? _timer;

  late bool _show;
  bool get show => _show;
  late bool _isPaused;
  bool get isPaused => _isPaused;

  @override
  void initState() {
    super.initState();
    _isPaused = Provider.of<DoRoutineModel>(context, listen: false).isPaused;
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
        hideInThreeSeconds();
      }
      _show = !show;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = 1 * MediaQuery.of(context).size.height / 3;
    return SizedBox(
      height: height,
      child: Stack(children: [
        GestureDetector(
          onTap: toggleShow,
          child: Container(
            color: Colors.transparent,
            child: const DetailText(),
          ),
        ),
        IgnorePointer(
          ignoring: !show,
          child: GestureDetector(
            onTap: toggleShow,
            child: AnimatedOpacity(
              opacity: show ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Container(
                color: Colors.transparent,
                child: const DetailControls(),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
