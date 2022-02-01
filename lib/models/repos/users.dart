import 'package:faker/faker.dart';
import 'package:mvp/models/user.dart';

User fakeUser() {
  final faker = Faker();
  final username = faker.internet.userName();
  return User(username: username);
}
