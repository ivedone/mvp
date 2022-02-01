// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:mvp/models/routine.dart';
import 'package:mvp/models/task.dart';
import 'package:mvp/models/user.dart';

class SeedUsers {
  static const User ChloeTing = User(username: 'chloeting');
}

class SeedTasks {
  static Task DeadBugs({int? id}) => Task.work(
      id: id,
      title: 'Dead Bugs',
      description:
          'Complete reps on one side, then switch. 12 total reps. Exhale as you sit back into your hips',
      seconds: 30);

  static Task RussianTwists({int? id}) => Task.work(
      id: id,
      title: 'Russian Twists',
      seconds: 60,
      description:
          'Alternate side to side. Aim to increase range with every rep.');

  static Task Plank({int? id}) =>
      Task.work(id: id, title: 'Plank', seconds: 60);

  static Task OneMinuteRest({int? id}) => Task.rest(id: id, seconds: 60);
}

class BuildTasks {
  static List<Task> AbsInTwoWeeks() {
    List<Task> tasks = [];
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
  static Routine AbsInTwoWeeks = Routine(
      title: 'Abs In Two Weeks',
      creator: SeedUsers.ChloeTing,
      tasks: BuildTasks.AbsInTwoWeeks());
}
