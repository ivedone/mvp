import 'package:flutter/material.dart';
import 'package:mvp/services/audio_notifier/audio_notifier.dart';
import 'package:provider/provider.dart';

class AudioNotifierSelector extends StatelessWidget {
  const AudioNotifierSelector({Key? key}) : super(key: key);

  Icon _button(AudioNotifierState state) {
    switch (state) {
      case AudioNotifierState.loading:
        return const Icon(Icons.volume_mute_rounded);
      case AudioNotifierState.all:
        return const Icon(Icons.volume_up_rounded);
      case AudioNotifierState.muted:
        return const Icon(Icons.volume_off_rounded);
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
