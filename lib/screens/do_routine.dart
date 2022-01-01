import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mvp/models/do_routine.dart';
import 'package:mvp/components/do_routine/list.dart';
import 'package:mvp/components/do_routine/detail/detail.dart';
import 'package:mvp/models/audio_notifier/audio_notifier.dart';
import 'package:mvp/models/countdown.dart';

class DoRoutineFullScreenModal extends StatelessWidget {
  const DoRoutineFullScreenModal({
    Key? key,
  }) : super(key: key);

  _bypassLazyLoadingOfDependencies(BuildContext context) {
    Provider.of<CountdownModel>(context, listen: false);
    Provider.of<DoRoutineModel>(context, listen: false);
    Provider.of<AudioNotifier>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    _bypassLazyLoadingOfDependencies(context);

    return Selector<DoRoutineModel, bool>(
        selector: (_, DoRoutineModel doRoutine) => !doRoutine.hasRoutine,
        builder: (context, bool shouldNotRender, _) {
          if (shouldNotRender) return Container();
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: AppBar(
                leading: IconButton(
                    icon: const Icon(Icons.expand_more),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                title: Selector<DoRoutineModel, String>(
                    selector: (_, DoRoutineModel doRoutine) =>
                        doRoutine.routine!.title,
                    builder: (BuildContext context, String title, _) => Text(
                        title,
                        style: Theme.of(context).textTheme.subtitle1)),
                actions: [
                  IconButton(
                      icon: const Icon(Icons.more_horiz_outlined),
                      onPressed: () {})
                ]),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                DoRoutineDetailWidget(),
                Expanded(child: DoRoutineListWidget()),
              ],
            ),
          );
        });
  }
}
