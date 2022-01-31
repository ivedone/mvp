import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mvp/services/audio/handler.dart';
import 'package:provider/provider.dart';

class AudioNotifierSelector extends StatelessWidget {
  final double? size;
  const AudioNotifierSelector({Key? key, this.size}) : super(key: key);

  Icon _button(bool muted) {
    if (muted) {
      return Icon(Icons.volume_off_rounded, size: size);
    } else {
      return Icon(Icons.volume_up_rounded, size: size);
    }
  }

  @override
  Widget build(BuildContext context) {
    final toggle = GetIt.I<AudioHandler>().toggle;
    return Selector<AudioHandler, bool>(
        selector: (_, AudioHandler audioNotifier) => audioNotifier.muted,
        builder: (_, bool muted, __) {
          return IconButton(icon: _button(muted), onPressed: toggle);
        });
  }
}
