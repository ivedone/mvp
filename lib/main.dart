import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mvp/services/profile.dart';
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
    ChangeNotifierProvider<DoRoutine>(create: (_) => getIt<DoRoutine>()),
    ChangeNotifierProvider<AudioHandler>(create: (_) => getIt<AudioHandler>()),
    ChangeNotifierProvider<Profile>(create: (_) => getIt<Profile>()),
  ], child: const IvedoneApp()));
}
