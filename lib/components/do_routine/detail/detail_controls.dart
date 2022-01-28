import 'package:flutter/material.dart';
import 'package:mvp/components/do_routine/detail/audio_notifier_selector.dart';

import 'package:mvp/models/do_routine.dart';
import 'package:provider/provider.dart';

class DetailControlsWidget extends StatelessWidget {
  const DetailControlsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextStyle secondaryTextStyle = themeData.textTheme.caption!;
    final TextStyle primaryTextStyle =
        secondaryTextStyle.copyWith(color: Colors.white);
    return Container(
      color: const Color.fromRGBO(0, 0, 0, 0.5),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _padding(
                Row(mainAxisAlignment: MainAxisAlignment.end, children: const [
              AudioNotifierSelector(),
            ])),
            _padding(Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _buttons(context),
            )),
            _padding(Row(children: [
              Selector<DoRoutineModel, String>(
                  selector: (_, model) => model.elapsedString,
                  builder: (_, String elapsed, __) =>
                      Text(elapsed, style: primaryTextStyle)),
              Text(' / ', style: secondaryTextStyle),
              Selector<DoRoutineModel, String>(
                  selector: (_, model) => model.remainingString,
                  builder: (_, String remaining, __) =>
                      Text(remaining, style: secondaryTextStyle)),
              Expanded(child: Container()),
              IconButton(
                  splashColor: Colors.white,
                  onPressed: () {},
                  icon: const Icon(Icons.fullscreen)),
            ])),
          ]),
    );
  }

  List<Widget> _buttons(BuildContext context) {
    final DoRoutineModel doRoutine =
        Provider.of<DoRoutineModel>(context, listen: false);
    final Widget skipBack10Sec = IconButton(
        splashColor: Colors.transparent,
        onPressed: doRoutine.skipBack10Sec,
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
    final Widget skipForward10Sec = IconButton(
        splashColor: Colors.transparent,
        onPressed: doRoutine.skipForward10Sec,
        icon: const Icon(Icons.fast_forward));
    return [skipBack10Sec, skipBack, toggle, skipForward, skipForward10Sec];
  }

  Widget _padding(Widget child) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8), child: child);
  }
}
