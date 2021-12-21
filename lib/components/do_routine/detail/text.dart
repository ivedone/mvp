import 'package:flutter/material.dart';

import 'package:mvp/components/do_routine/progress/progress.dart';

class DoRoutineDetailText extends StatelessWidget {
  const DoRoutineDetailText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextStyle secondaryTextStyle = themeData.textTheme.caption!;
    final TextStyle primaryTextStyle =
        secondaryTextStyle.copyWith(color: Colors.white);
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(children: [
                Text('XX:XX', style: primaryTextStyle),
                Text(' / ', style: secondaryTextStyle),
                Text('XX:XX', style: secondaryTextStyle),
                Expanded(child: Container()),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.favorite_border)),
              ])),
          const DoRoutineProgressIndicator(),
        ]));
  }
}
