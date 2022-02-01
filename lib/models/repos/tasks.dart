import 'dart:math';

import 'package:faker/faker.dart';
import 'package:mvp/models/task.dart';
import 'package:mvp/util/seed.dart';

Task fakeTask({int? id}) {
  final faker = Faker();

  var sport = faker.sport.name();
  var dish = faker.food.dish();
  var title = '$sport $dish';

  final description = faker.lorem.words(3 + Random().nextInt(5)).join(' ');
  final seconds = 15 * (1 + Random().nextInt(4));

  return Task.work(
      id: id,
      title: title,
      description: description,
      seconds: seconds,
      imageUrl: fakeImageUrl());
}

Task fakeRest({int? id}) {
  var seconds = 30 * (1 + Random().nextInt(4));
  return Task.rest(id: id, seconds: seconds);
}
