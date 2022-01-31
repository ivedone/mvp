import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mvp/services/setup.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'services/countdown.dart';
import 'services/do_routine.dart';
import 'services/audio/handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUp();
  final GetIt getIt = GetIt.instance;
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<Countdown>(create: (_) => getIt<Countdown>()),
    ChangeNotifierProvider<DoRoutineModel>(
        create: (_) => getIt<DoRoutineModel>()),
    ChangeNotifierProvider<AudioHandler>(create: (_) => getIt<AudioHandler>()),
  ], child: const IvedoneApp()));
}
