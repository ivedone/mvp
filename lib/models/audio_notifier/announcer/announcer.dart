abstract class Announcer<T> {
  final Duration target;
  Announcer({required this.target});

  Future<void> init();

  bool isAboutTime(Duration time, Duration target) {
    const int margin = 50;
    final int diff = time.inMilliseconds - target.inMilliseconds;
    return -margin <= diff && diff <= margin;
  }

  bool shouldAnnounce(Duration time);
  bool get isAnnouncing;
  Future<bool> announceSafely(Duration time, T payload);

  Future<void> reset();
}
