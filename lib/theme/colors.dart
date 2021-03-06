import 'package:flutter/material.dart';

final ColorScheme activeColorScheme = ColorScheme(
  primary: Colors.black,
  primaryVariant: Colors.grey.shade900,
  secondary: Colors.green.shade500,
  secondaryVariant: Colors.green.shade900,
  surface: const Color.fromRGBO(0, 0, 0, 0.75),
  background: Colors.black,
  error: Colors.green.shade900,
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onSurface: Colors.white,
  onError: Colors.white,
  onBackground: Colors.white,
  brightness: Brightness.dark,
);

final ColorScheme getReadyColorScheme = activeColorScheme.copyWith(
  secondary: Colors.yellow.shade500,
  secondaryVariant: Colors.yellow.shade900,
);

final ColorScheme restColorScheme = activeColorScheme.copyWith(
  secondary: Colors.blue.shade500,
  secondaryVariant: Colors.blue.shade900,
);
