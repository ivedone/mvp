import 'package:flutter/foundation.dart' show ChangeNotifier;

class AudioHandler with ChangeNotifier {
  bool _muted = false;
  bool get muted => _muted;

  toggle() async {
    _muted = !muted;
    notifyListeners();
  }

  init() async {}

  onTick() {}
}
