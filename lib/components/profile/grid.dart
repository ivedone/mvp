import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mvp/models/repos/local_routines.dart';
import 'package:mvp/models/routine.dart';
import 'package:mvp/services/do_routine.dart';

class RoutineGridWidget extends StatelessWidget {
  const RoutineGridWidget({Key? key}) : super(key: key);
  final double gap = 10;

  @override
  Widget build(BuildContext context) {
    final List<Routine> routines = GetIt.I<LocalRoutines>().getAll();

    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: gap,
      crossAxisSpacing: gap,
      children: _children(routines),
    );
  }

  List<Widget> _children(List<Routine> routines) {
    final children = <Widget>[];
    for (int i = 0; i < routines.length; i++) {
      final routine = routines[i];
      children.add(RoutineGridItem(routine: routine));
    }
    return children;
  }
}

class RoutineGridItem extends StatelessWidget {
  final Routine routine;
  RoutineGridItem({Key? key, required this.routine}) : super(key: key);
  final selectRoutine = GetIt.I<DoRoutine>().selectRoutine;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectRoutine(routine),
      child: Center(child: Text(routine.title)),
    );
  }
}
