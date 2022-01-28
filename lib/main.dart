import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'services/audio_notifier/audio_notifier.dart';
import 'services/countdown.dart';
import 'services/do_routine.dart';
import 'util/audio_session.dart';
import 'util/seed.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final CountdownModel countdown = CountdownModel();
  final DoRoutineModel doRoutine = DoRoutineModel(countdown: countdown)
    ..selectRoutine(SeedRoutines.AbsInTwoWeeks);
  final AudioNotifier audioNotifier = AudioNotifier(doRoutine: doRoutine);
  await audioNotifier.init();
  await initAudioSession();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<CountdownModel>(create: (_) => countdown),
    ChangeNotifierProvider<DoRoutineModel>(create: (_) => doRoutine),
    ChangeNotifierProvider<AudioNotifier>(create: (_) => audioNotifier),
  ], child: const IvedoneApp()));
}
