import 'package:flutter/material.dart';
import 'package:mvp/services/audio_notifier/audio_notifier.dart';
import 'package:provider/provider.dart';

class AudioNotifierSelector extends StatelessWidget {
  final double? size;
  const AudioNotifierSelector({Key? key, this.size}) : super(key: key);

  Icon _button(AudioNotifierState state) {
    switch (state) {
      case AudioNotifierState.loading:
        return Icon(
          Icons.volume_mute_rounded,
          size: size,
        );
      case AudioNotifierState.all:
        return Icon(Icons.volume_up_rounded, size: size);
      case AudioNotifierState.muted:
        return Icon(Icons.volume_off_rounded, size: size);
    }
  }

  @override
  Widget build(BuildContext context) {
    final toggle = Provider.of<AudioNotifier>(context, listen: false).toggle;
    return Selector<AudioNotifier, AudioNotifierState>(
        selector: (_, AudioNotifier audioNotifier) => audioNotifier.state,
        builder: (_, AudioNotifierState state, __) {
          return IconButton(
            icon: _button(state),
            onPressed: toggle,
          );
        });
  }
}
