import 'dart:math';

import 'package:faker/faker.dart';
import 'package:mvp/models/repos/tasks.dart';
import 'package:mvp/models/repos/users.dart';
import 'package:mvp/models/routine.dart';
import 'package:mvp/models/task.dart';

abstract class LocalRoutines {
  List<Routine> getAll();
}

final List<String> _keywords = [
  'sport',
  'athlete',
  'fitness',
  'NBA',
  'HIIT',
  'exercise',
  'influencer'
];

Routine fakeRoutine() {
  var length = 3 + Random().nextInt(12);
  final List<Task> tasks = [];
  for (int i = 0; i < length; i++) {
    if (i > 0 && i % 4 == 0) {
      tasks.add(fakeRest());
    } else {
      tasks.add(fakeTask());
    }
  }
  final user = fakeUser();

  final faker = Faker();
  final name = faker.person.name();
  final sport = faker.sport.name();
  final title = '$name $sport';

  _keywords.shuffle();

  final imageUrl = faker.image.image(
      height: 1080, width: 1080, keywords: _keywords.sublist(2), random: true);

  return Routine(creator: user, title: title, tasks: tasks, imageUrl: imageUrl);
}

class FakeLocalRoutines implements LocalRoutines {
  final List<Routine> _routines = [];
  FakeLocalRoutines() {
    for (int i = 0; i < 11; i++) {
      _routines.add(fakeRoutine());
    }
  }

  @override
  List<Routine> getAll() => _routines;
}
