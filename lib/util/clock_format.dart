String toMinutesAndSeconds(Duration dur) {
  int seconds = dur.inSeconds;
  int minutes = seconds ~/ Duration.secondsPerMinute;
  seconds -= minutes * Duration.secondsPerMinute;
  return [toOneDigit(minutes), toTwoDigits(seconds)].join(':');
}

String toOneDigit(int x) {
  if (x < 0) return toOneDigit(-x);
  return x.toString();
}

String toTwoDigits(int x) {
  if (x < 0) return toTwoDigits(-x);
  if (x < 10) return '0' + x.toString();
  return x.toString();
}
