import 'dart:math';

import 'package:faker/faker.dart';
import 'package:mvp/models/repos/tasks.dart';
import 'package:mvp/models/repos/users.dart';
import 'package:mvp/models/routine.dart';
import 'package:mvp/models/task.dart';
import 'package:mvp/util/seed.dart';

abstract class LocalRoutines {
  List<Routine> getAll();
}

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

  return Routine(
      creator: user, title: title, tasks: tasks, imageUrl: fakeImageUrl());
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
