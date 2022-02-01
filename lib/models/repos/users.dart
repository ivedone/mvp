import 'package:faker/faker.dart';
import 'package:mvp/models/user.dart';

User fakeUser() {
  final faker = Faker();
  final username = faker.internet.userName();
  final imageUrl = faker.image
      .image(height: 180, width: 180, keywords: ['profile', 'person']);
  return User(username: username, imageUrl: imageUrl);
}
