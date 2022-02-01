import 'package:get_it/get_it.dart';
import 'package:mvp/models/repos/local_routines.dart';
import 'package:mvp/services/audio/handler.dart';
import 'package:mvp/services/profile.dart';

import 'audio/session.dart';
import 'countdown.dart';
import 'do_routine.dart';

setUp() async {
  final GetIt getIt = GetIt.instance;

  // Repositories
  getIt.registerSingleton<LocalRoutines>(FakeLocalRoutines());

  // View Models
  final Countdown countdown = Countdown();
  final DoRoutine doRoutine = DoRoutine(countdown: countdown);
  final AudioHandler audioHandler = AudioHandler();
  final Profile profile = LocalProfile();

  getIt.registerSingleton<Countdown>(countdown);
  getIt.registerSingleton<DoRoutine>(doRoutine);
  getIt.registerSingleton<AudioHandler>(audioHandler);
  getIt.registerSingleton<Profile>(profile);

  await initAudioSession();
}
