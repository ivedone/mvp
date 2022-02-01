import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mvp/services/profile.dart';
import 'package:provider/provider.dart';

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<Profile, String>(
      selector: (_, profile) => profile.user.imageUrl!,
      builder: (_, imageUrl, __) {
        return CircleAvatar(
          minRadius: 50,
          maxRadius: 50,
          backgroundImage: CachedNetworkImageProvider(imageUrl),
        );
      },
    );
  }
}
