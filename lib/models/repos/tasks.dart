import 'dart:math';

import 'package:faker/faker.dart';
import 'package:mvp/models/task.dart';

Task fakeTask({int? id}) {
  final faker = Faker();

  var sport = faker.sport.name();
  var job = faker.job.title();
  var vehicle = faker.vehicle.model();
  var title = '$sport $job $vehicle';

  final description = faker.lorem.words(3 + Random().nextInt(5)).join(' ');
  final seconds = 15 * (1 + Random().nextInt(4));

  return Task.work(
      id: id, title: title, description: description, seconds: seconds);
}

Task fakeRest({int? id}) {
  var seconds = 30 * (1 + Random().nextInt(4));
  return Task.rest(id: id, seconds: seconds);
}
