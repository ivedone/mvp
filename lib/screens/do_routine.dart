import 'package:flutter/material.dart';
import 'package:mvp/components/do_routine/list.dart';
import 'package:mvp/models/do_routine.dart';
import 'package:provider/provider.dart';

class DoRoutineFullScreenModal extends StatelessWidget {
  const DoRoutineFullScreenModal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<DoRoutineModel, bool>(
        selector: (_, DoRoutineModel doRoutine) => !doRoutine.hasRoutine,
        builder: (context, bool shouldNotRender, _) {
          if (shouldNotRender) return Container();
          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: AppBar(
                leading: IconButton(
                    icon: const Icon(Icons.expand_more), onPressed: () {}),
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
              children: [
                /// DoRoutineDetailWidget
                /// TODO: Make DoRoutineDetailWidget resiazable as window size changes
                SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: Container(
                        color: Colors.red[300],
                        child: const Center(
                            child: Text('DoRoutineDetailWidget')))),
                const Expanded(child: DoRoutineListWidget()),
              ],
            ),
          );
        });
  }
}
