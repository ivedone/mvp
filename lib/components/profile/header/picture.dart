import 'package:flutter/material.dart';
import 'package:mvp/models/repos/users.dart';
import 'package:mvp/models/user.dart';

class ProfilePictureWidget extends StatelessWidget {
  ProfilePictureWidget({Key? key}) : super(key: key);

  final User user = fakeUser();

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      minRadius: 50,
      maxRadius: 50,
      backgroundImage: NetworkImage(user.imageUrl!),
    );
  }
}
