// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:mvp/models/routine.dart';
import 'package:mvp/models/task.dart';
import 'package:mvp/models/user.dart';

class SeedUsers {
  static const UserModel ChloeTing = UserModel(username: 'chloeting');
}

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
      seconds: 60,
      description:
          'Alternate side to side. Aim to increase range with every rep.');

  static TaskModel Plank({int? id}) =>
      TaskModel.work(id: id, title: 'Plank', seconds: 60);

  static TaskModel OneMinuteRest({int? id}) =>
      TaskModel.rest(id: id, seconds: 60);
}

class BuildTasks {
  static List<TaskModel> AbsInTwoWeeks() {
    List<TaskModel> tasks = [];
    int getId() => tasks.length;
    for (int i = 0; i < 5; i++) {
      if (i > 0) tasks.add(SeedTasks.OneMinuteRest(id: getId()));
      tasks.add(SeedTasks.DeadBugs(id: getId()));
      tasks.add(SeedTasks.RussianTwists(id: getId()));
      tasks.add(SeedTasks.Plank(id: getId()));
    }
    return tasks;
  }
}

class SeedRoutines {
  static RoutineModel AbsInTwoWeeks = RoutineModel(
      title: 'Abs In Two Weeks',
      creator: SeedUsers.ChloeTing,
      tasks: BuildTasks.AbsInTwoWeeks());
}
