import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mvp/models/routine.dart';
import 'package:mvp/services/do_routine.dart';
import 'package:mvp/services/profile.dart';
import 'package:provider/provider.dart';

class RoutineGridWidget extends StatelessWidget {
  const RoutineGridWidget({Key? key}) : super(key: key);
  final double gap = 10;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.background,
      child: Selector<Profile, List<Routine>>(
          selector: (_, profile) => profile.myRoutines(),
          builder: (_, routines, __) {
            return GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: gap,
              crossAxisSpacing: gap,
              children: _children(routines),
            );
          }),
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
      child: Ink(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(routine.imageUrl!), fit: BoxFit.cover)),
      ),
    );
  }
}
