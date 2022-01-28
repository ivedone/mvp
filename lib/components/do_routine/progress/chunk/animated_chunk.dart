import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mvp/services/countdown.dart';

import 'static_chunk.dart';

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
