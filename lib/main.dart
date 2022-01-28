import 'package:flutter/material.dart';
import 'package:mvp/app.dart';
import 'package:mvp/models/audio_notifier/audio_notifier.dart';
import 'package:mvp/models/countdown.dart';
import 'package:mvp/models/do_routine.dart';
import 'package:mvp/util/audio_service.dart';
import 'package:mvp/util/seed.dart';
import 'package:provider/provider.dart';

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
