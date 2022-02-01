import 'package:flutter/material.dart';

class TextBlurbWidget extends StatelessWidget {
  final String title;
  final int number;
  const TextBlurbWidget({Key? key, required this.title, required this.number})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$number', style: Theme.of(context).textTheme.headline6),
          Text(title, style: Theme.of(context).textTheme.bodyText2),
        ]);
  }
}
