import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:mvp/services/do_routine.dart';
import 'package:mvp/models/routine.dart';

import 'package:mvp/components/do_routine/task.dart';

class DoRoutineListWidget extends StatefulWidget {
  const DoRoutineListWidget({Key? key}) : super(key: key);

  @override
  _DoRoutineListWidgetState createState() => _DoRoutineListWidgetState();
}

class _DoRoutineListWidgetState extends State<DoRoutineListWidget> {
  final ItemScrollController itemScrollController = ItemScrollController();
  late final int initialScrollIndex;
  late int prevIndex;
  late bool wasRunning;

  void scrollToIndex(int index) {
    itemScrollController.scrollTo(
        index: index,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic);
  }

  @override
  void initState() {
    super.initState();
    final DoRoutine doRoutine = Provider.of<DoRoutine>(context, listen: false);
    final int index = doRoutine.index;
    prevIndex = index;
    initialScrollIndex = index;
    wasRunning = doRoutine.isRunning;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final DoRoutine doRoutine = Provider.of<DoRoutine>(context);
    final int index = doRoutine.index;
    if (doRoutine.isValidIndex(index) && prevIndex != doRoutine.index) {
      scrollToIndex(index);
      prevIndex = index;
    } else if (doRoutine.isRunning && !wasRunning) {
      scrollToIndex(index);
    }
    wasRunning = doRoutine.isRunning;
  }

  @override
  Widget build(BuildContext context) {
    return Selector<DoRoutine, Routine>(
        selector: (_, DoRoutine doRoutine) => doRoutine.routine!,
        builder: (_, Routine routine, __) => Selector<DoRoutine, int>(
            selector: (_, DoRoutine doRoutine) => doRoutine.index,
            builder: (BuildContext listContext, int currentIndex, __) {
              final int length = routine.length;
              double spacerHeight =
                  2 * MediaQuery.of(listContext).size.height / 3 - 120;
              return Expanded(
                  child: ScrollablePositionedList.builder(
                      itemScrollController: itemScrollController,
                      itemCount: length + 1,
                      initialScrollIndex: initialScrollIndex,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext itemContext, int taskIndex) {
                        if (taskIndex == length) {
                          return SizedBox(height: spacerHeight);
                        }
                        return TaskWidget(
                            taskIndex: taskIndex,
                            task: routine.atIndex(taskIndex)!);
                      }));
            }));
  }
}
