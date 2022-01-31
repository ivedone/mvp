import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mvp/services/do_routine.dart';
import 'package:mvp/components/do_routine/toggle_button.dart';

import 'audio_notifier_selector.dart';

class DetailControlsWidget extends StatelessWidget {
  const DetailControlsWidget({Key? key}) : super(key: key);
  final double smButtonSize = 28;
  final double lgButtonSize = 65;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextStyle secondaryTextStyle = themeData.textTheme.caption!;
    final TextStyle primaryTextStyle =
        secondaryTextStyle.copyWith(color: Colors.white);
    return Material(
      color: const Color.fromRGBO(0, 0, 0, 0.5),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _padding(Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              AudioNotifierSelector(size: smButtonSize),
            ])),
            _padding(SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _buttons(context),
              ),
            )),
            _padding(SizedBox(
              child: Row(children: [
                Selector<DoRoutine, String>(
                    selector: (_, doRoutine) => doRoutine.elapsedString,
                    builder: (_, String elapsed, __) =>
                        Text(elapsed, style: primaryTextStyle)),
                Text(' / ', style: secondaryTextStyle),
                Selector<DoRoutine, String>(
                    selector: (_, doRoutine) => doRoutine.remainingString,
                    builder: (_, String remaining, __) =>
                        Text(remaining, style: secondaryTextStyle)),
                Expanded(child: Container()),
                IconButton(
                    iconSize: smButtonSize,
                    onPressed: () {},
                    icon: const Icon(Icons.fullscreen)),
              ]),
            )),
          ]),
    );
  }

  List<Widget> _buttons(BuildContext context) {
    final DoRoutine doRoutine = Provider.of<DoRoutine>(context, listen: false);
    final Widget skipBack = IconButton(
        iconSize: smButtonSize,
        onPressed: doRoutine.skipBack,
        icon: const Icon(Icons.skip_previous));
    final Widget toggle = ToggleButton(size: lgButtonSize, hideSplash: false);
    final Widget skipForward = IconButton(
        iconSize: smButtonSize,
        onPressed: doRoutine.skipForward,
        icon: const Icon(Icons.skip_next));
    return [
      Expanded(child: skipBack),
      Expanded(child: toggle),
      Expanded(child: skipForward),
    ];
  }

  Widget _padding(Widget child) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8), child: child);
  }
}
