import 'package:flutter/material.dart';
import 'package:mvp/app.dart';
import 'package:mvp/models/audio_notifier/audio_notifier.dart';
import 'package:mvp/models/countdown.dart';
import 'package:mvp/models/do_routine.dart';
import 'package:mvp/util/seed.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<CountdownModel>(
        create: (_) => CountdownModel(),
      ),
      ChangeNotifierProxyProvider<CountdownModel, DoRoutineModel>(
          create: (BuildContext context) {
            final CountdownModel countdown =
                Provider.of<CountdownModel>(context, listen: false);
            return DoRoutineModel(countdown: countdown)
              ..selectRoutine(SeedRoutines.AbsInTwoWeeks);
          },
          update: (_, __, DoRoutineModel? doRoutine) => doRoutine!),
      ChangeNotifierProxyProvider<DoRoutineModel, AudioNotifier>(
          create: (BuildContext context) {
            final doRoutine =
                Provider.of<DoRoutineModel>(context, listen: false);
            return AudioNotifier(doRoutine: doRoutine);
          },
          update: (_, __, AudioNotifier? audioNotifier) => audioNotifier!),
    ], child: const IvedoneApp()),
  );
}
