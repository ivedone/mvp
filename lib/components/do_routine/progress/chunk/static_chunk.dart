import 'package:flutter/material.dart';

class StaticProgressChunk extends StatelessWidget {
  final double percentDone;
  const StaticProgressChunk({
    Key? key,
    required this.percentDone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return LinearProgressIndicator(
        minHeight: 5.0,
        value: percentDone,
        color: colorScheme.onSecondary,
        backgroundColor: colorScheme.secondary);
  }
}
