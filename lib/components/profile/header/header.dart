import 'package:flutter/material.dart';
import 'package:mvp/components/profile/header/blurb.dart';

import 'picture.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ProfilePictureWidget(),
            const Expanded(
                child: TextBlurbWidget(title: 'Routines', number: 3)),
            const Expanded(
                child: TextBlurbWidget(title: 'Followers', number: 51)),
            const Expanded(
                child: TextBlurbWidget(title: 'Following', number: 13)),
          ],
        ),
      ),
    );
  }
}
