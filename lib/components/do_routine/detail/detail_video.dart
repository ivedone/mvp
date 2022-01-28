import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import 'package:mvp/models/do_routine.dart';
import 'package:mvp/models/task.dart';

class DetailVideo extends StatefulWidget {
  final TaskModel task;
  const DetailVideo({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  _DetailVideoState createState() => _DetailVideoState();
}

class _DetailVideoState extends State<DetailVideo> {
  late VideoPlayerController _controller;

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.task.video!,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
      ..setVolume(0.0)
      ..initialize().then((_) {
        setState(() {});
      });

    final bool isRunning =
        Provider.of<DoRoutineModel>(context, listen: false).isRunning;
    update(isRunning);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final bool isRunning = Provider.of<DoRoutineModel>(context).isRunning;
    update(isRunning);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  update(bool isRunning) {
    if (isRunning && !_controller.value.isPlaying) {
      _controller.play();
    } else if (!isRunning && _controller.value.isPlaying) {
      _controller.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? IgnorePointer(
            child: Center(
                child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller))))
        : const Center(child: Text('Loading'));
  }
}
