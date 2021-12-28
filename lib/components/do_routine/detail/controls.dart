import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mvp/models/do_routine.dart';

class DetailControls extends StatelessWidget {
  const DetailControls({Key? key}) : super(key: key);

  List<Widget> _buttons(BuildContext context) {
    final DoRoutineModel doRoutine =
        Provider.of<DoRoutineModel>(context, listen: false);
    final Widget skipBack5Sec = IconButton(
        splashColor: Colors.transparent,
        onPressed: doRoutine.skipBack5Sec,
        icon: const Icon(Icons.fast_rewind));
    final Widget skipBack = IconButton(
        splashColor: Colors.transparent,
        onPressed: doRoutine.skipBack,
        icon: const Icon(Icons.skip_previous));
    final Widget toggle = IconButton(
        splashColor: Colors.transparent,
        iconSize: 35,
        onPressed: doRoutine.toggle,
        icon: Selector<DoRoutineModel, bool>(
            selector: (_, DoRoutineModel model) => model.isPaused,
            builder: (_, bool isPaused, __) => isPaused
                ? const Icon(Icons.play_arrow)
                : const Icon(Icons.pause)));
    final Widget skipForward = IconButton(
        splashColor: Colors.transparent,
        onPressed: doRoutine.skipForward,
        icon: const Icon(Icons.skip_next));
    final Widget skipForward5Sec = IconButton(
        splashColor: Colors.transparent,
        onPressed: doRoutine.skipForward5Sec,
        icon: const Icon(Icons.fast_forward));
    return [skipBack5Sec, skipBack, toggle, skipForward, skipForward5Sec];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _buttons(context),
            )));
  }
}
