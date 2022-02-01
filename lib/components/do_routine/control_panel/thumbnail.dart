import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mvp/util/image_cache.dart';
import 'package:provider/provider.dart';

import 'package:mvp/services/do_routine.dart';
import 'package:mvp/models/task.dart';

class ControlPanelThumbnail extends StatelessWidget {
  const ControlPanelThumbnail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<DoRoutine, Task>(
      selector: (_, DoRoutine model) => model.currentTask!,
      builder: (_, Task task, __) {
        final bool hasImage = task.imageUrl != null;
        return AspectRatio(
            aspectRatio: 1 / 1,
            child: Material(
              color: getTaskTheme(task.type).colorScheme.secondary,
              child: hasImage ? cachedImage(context, task.imageUrl!) : null,
            ));
      },
    );
  }
}
