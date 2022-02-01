import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mvp/models/routine.dart';
import 'package:mvp/services/do_routine.dart';
import 'package:mvp/services/profile.dart';
import 'package:mvp/util/clock_format.dart';
import 'package:mvp/util/image_cache.dart';
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
    return Stack(
      children: [
        ShaderMask(
            shaderCallback: (Rect bounds) => const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [Colors.black, Colors.white],
                    tileMode: TileMode.mirror)
                .createShader(bounds),
            child: AspectRatio(
                aspectRatio: 1,
                child: Container(
                    color: Theme.of(context).colorScheme.primaryVariant,
                    child: CachedNetworkImage(
                        imageUrl: routine.imageUrl!,
                        placeholder: (_, url) =>
                            cachedImage(context, routine.imageUrl!))))),
        Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(toMinutesAndSeconds(routine.totalDuration),
                  textAlign: TextAlign.right)),
          Expanded(child: Container()),
          Padding(
              padding: const EdgeInsets.all(8.0), child: Text(routine.title)),
        ]),
        Material(
            color: Colors.transparent,
            child: InkWell(onTap: () => selectRoutine(routine)))
      ],
    );
  }
}
