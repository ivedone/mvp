import 'package:flutter/material.dart';
import 'package:mvp/components/do_routine/detail/audio_notifier_selector.dart';

import 'package:mvp/models/do_routine.dart';
import 'package:provider/provider.dart';

class DetailText extends StatelessWidget {
  const DetailText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextStyle secondaryTextStyle = themeData.textTheme.caption!;
    final TextStyle primaryTextStyle =
        secondaryTextStyle.copyWith(color: Colors.white);
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    AudioNotifierSelector(),
                  ])),
          Expanded(child: Container()),
          Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(children: [
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
                    splashColor: Colors.transparent,
                    onPressed: () {},
                    icon: const Icon(Icons.fullscreen)),
              ])),
        ]);
  }
}
