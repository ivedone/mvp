import 'package:flutter/material.dart';
import 'package:mvp/components/do_routine/list.dart';
import 'package:mvp/models/routine.dart';

class DoRoutineOverlay extends StatelessWidget {
  final RoutineModel routine;
  const DoRoutineOverlay({
    Key? key,
    required this.routine,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.expand_more),
            onPressed: () {},
          ),
          title: Text(
            routine.title,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_horiz_outlined),
              onPressed: () {},
            ),
          ]),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// DoRoutineDetailWidget
          SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: Container(
                  color: Colors.red[300],
                  child: const Center(child: Text('DoRoutineDetailWidget')))),
          Expanded(child: DoRoutineListWidget(routine: routine)),
        ],
      ),
    );
  }
}
