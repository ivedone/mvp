import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:mvp/components/do_routine/task.dart';
import 'package:mvp/models/do_routine.dart';
import 'package:mvp/models/routine.dart';

class DoRoutineListWidget extends StatefulWidget {
  const DoRoutineListWidget({Key? key}) : super(key: key);

  @override
  _DoRoutineListWidgetState createState() => _DoRoutineListWidgetState();
}

class _DoRoutineListWidgetState extends State<DoRoutineListWidget> {
  final ItemScrollController itemScrollController = ItemScrollController();
  late final int initialScrollIndex;
  late int prevIndex;

  void scrollToIndex(int index) {
    itemScrollController.scrollTo(
        index: index,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic);
  }

  @override
  void initState() {
    super.initState();
    late final int index =
        Provider.of<DoRoutineModel>(context, listen: false).index;
    initialScrollIndex = index;
    prevIndex = index;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final int index = Provider.of<DoRoutineModel>(context).index;
    if (prevIndex != index) {
      // print('didChangeD: $index');
      scrollToIndex(index);
      prevIndex = index;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Selector<DoRoutineModel, RoutineModel>(
        selector: (_, DoRoutineModel doRoutine) => doRoutine.routine!,
        builder: (_, RoutineModel routine, __) => Selector<DoRoutineModel, int>(
            selector: (_, DoRoutineModel doRoutine) => doRoutine.index,
            builder: (BuildContext context, int currentIndex, __) {
              return Expanded(
                  child: ScrollablePositionedList.builder(
                      itemScrollController: itemScrollController,
                      itemCount: routine.length,
                      initialScrollIndex: initialScrollIndex,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int taskIndex) {
                        return TaskWidget(
                            taskIndex: taskIndex,
                            task: routine.atIndex(taskIndex)!);
                      }));
            }));
  }
}
