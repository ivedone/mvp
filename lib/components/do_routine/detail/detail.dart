import 'dart:async';

import 'package:flutter/material.dart';

import 'text.dart';
import 'controls.dart';

class DoRoutineDetailWidget extends StatefulWidget {
  const DoRoutineDetailWidget({Key? key}) : super(key: key);

  @override
  _DoRoutineDetailWidgetState createState() => _DoRoutineDetailWidgetState();
}

class _DoRoutineDetailWidgetState extends State<DoRoutineDetailWidget> {
  bool _show = false;
  Timer? _timer;

  toggleShow() {
    setState(() {
      if (_show) {
        _timer?.cancel();
      } else {
        _timer = Timer(const Duration(seconds: 3), () {
          setState(() {
            _show = false;
          });
        });
      }
      _show = !_show;
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
          ignoring: !_show,
          child: GestureDetector(
            onTap: toggleShow,
            child: AnimatedOpacity(
              opacity: _show ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 150),
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
