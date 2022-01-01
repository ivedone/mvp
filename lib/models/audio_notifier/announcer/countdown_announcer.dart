import 'package:mvp/models/audio_notifier/announcer/announcer.dart';

class CountdownAnnouncer extends Announcer {
  CountdownAnnouncer() : super(target: const Duration(seconds: 3));

  bool _isAnnouncing = false;
  @override
  bool get isAnnouncing => _isAnnouncing;

  @override
  bool shouldAnnounce(Duration time) =>
      !isAnnouncing && isAboutTime(time, target);

  @override
  Future<bool> announceSafely(Duration time, payload) async {
    if (shouldAnnounce(time)) {
      _isAnnouncing = true;
      print('Announcing countdown ${time.inMicroseconds}');
      _isAnnouncing = false;
      return true;
    }
    return false;
  }

  @override
  Future<void> reset() async {}
}
