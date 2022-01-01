import 'package:flutter/foundation.dart' show ChangeNotifier;

enum AudioNotifierState { loading, muted, alertsOnly, all }

class AudioNotifier with ChangeNotifier {
  AudioNotifier() {
    _initState();
  }

  AudioNotifierState _state = AudioNotifierState.loading;
  AudioNotifierState get state => _state;
  set state(AudioNotifierState state) {
    _state = state;
    notifyListeners();
  }

  bool get loading => state == AudioNotifierState.loading;
  bool get muted => state == AudioNotifierState.muted;
  bool get alertsOnly => state == AudioNotifierState.alertsOnly;
  bool get all => state == AudioNotifierState.all;

  handleTap() {
    if (loading) return;
    if (all) {
      state = AudioNotifierState.alertsOnly;
    } else if (alertsOnly) {
      state = AudioNotifierState.muted;
    } else if (muted) {
      state = AudioNotifierState.all;
    }
  }

  _initState() async {
    state = AudioNotifierState.all;
  }
}
