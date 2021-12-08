import 'package:flutter/material.dart';
import 'package:mvp/components/do_routine.dart';

class DoRoutineOverlay extends StatelessWidget {
  const DoRoutineOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.expand_more),
            onPressed: () {},
          ),
          title: Text(
            'DoRoutineOverlay',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.more_horiz_outlined),
              onPressed: () {},
            ),
          ]),
      body: const DoRoutineWidget(),
    );
  }
}
