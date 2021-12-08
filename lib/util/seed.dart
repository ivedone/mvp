// ignore_for_file: non_constant_identifier_names

import 'package:mvp/models/task.dart';

class SeedTasks {
  static TaskModel DeadBugs({int? id}) => TaskModel.work(
      id: id,
      title: 'Dead Bugs',
      description:
          'Complete reps on one side, then switch. 12 total reps. Exhale as you sit back into your hips',
      seconds: 30);

  static TaskModel RussianTwists({int? id}) => TaskModel.work(
      id: id,
      title: 'Russian Twists',
      seconds: 30,
      description:
          'Alternate side to side. Aim to increase range with every rep.');

  static TaskModel Plank({int? id}) =>
      TaskModel.work(id: id, title: 'Plank', seconds: 60);

  static TaskModel OneMinuteRest({int? id}) =>
      TaskModel.rest(id: id, seconds: 60);
}
