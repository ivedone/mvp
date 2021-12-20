import 'package:flutter/material.dart';
import 'package:mvp/components/progress/chunk/static_chunk.dart';
import 'package:mvp/models/countdown.dart';
import 'package:mvp/models/do_routine.dart';
import 'package:provider/provider.dart';

class AnimatedProgressChunk extends StatelessWidget {
  const AnimatedProgressChunk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<CountdownModel, double>(
        selector: (_, CountdownModel countdown) => countdown.percentDone,
        builder: (BuildContext context, double percentDone, _) {
          return StaticProgressChunk(percentDone: percentDone);
        });
  }
}
