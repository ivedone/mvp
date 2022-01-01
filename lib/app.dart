import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mvp/screens/home.dart';
import 'package:mvp/theme/theme.dart';

import 'models/countdown.dart';
import 'models/do_routine.dart';
import 'models/audio_notifier/audio_notifier.dart';

class IvedoneApp extends StatelessWidget {
  const IvedoneApp({Key? key}) : super(key: key);

  _forceLazyLoadingOfDependencies(BuildContext context) {
    Provider.of<CountdownModel>(context, listen: false);
    Provider.of<DoRoutineModel>(context, listen: false);
    Provider.of<AudioNotifier>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    _forceLazyLoadingOfDependencies(context);
    return MaterialApp(
        title: 'ivedone',
        theme: activeTheme,
        debugShowCheckedModeBanner: false,
        home: const HomeScreen());
  }
}
