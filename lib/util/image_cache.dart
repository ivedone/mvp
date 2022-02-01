import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget cachedImage(BuildContext context, String url) {
  return Center(
      child: SpinKitPulse(
    color: Theme.of(context).colorScheme.onPrimary,
  ));
}
