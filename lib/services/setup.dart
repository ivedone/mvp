import 'package:get_it/get_it.dart';
import 'package:mvp/services/audio/handler.dart';
import 'package:mvp/util/seed.dart';
import 'audio/session.dart';
import 'countdown.dart';
import 'do_routine.dart';

setUp() async {
  final GetIt getIt = GetIt.instance;
  final Countdown countdown = Countdown();
  final DoRoutine doRoutine = DoRoutine(countdown: countdown)
    ..selectRoutine(SeedRoutines.AbsInTwoWeeks);
  final AudioHandler audioHandler = AudioHandler();

  getIt.registerSingleton<Countdown>(countdown);
  getIt.registerSingleton<DoRoutine>(doRoutine);
  getIt.registerSingleton<AudioHandler>(audioHandler);

  await initAudioSession();
}
