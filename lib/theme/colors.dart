import 'package:flutter/material.dart';

final ColorScheme activeColorScheme = ColorScheme(
  primary: Colors.black,
  primaryVariant: Colors.grey.shade900,
  secondary: Colors.red.shade300,
  secondaryVariant: Colors.red.shade600,
  surface: const Color.fromRGBO(0, 0, 0, 0.75),
  background: Colors.black,
  error: Colors.red.shade700,
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onSurface: Colors.white,
  onError: Colors.white,
  onBackground: Colors.white,
  brightness: Brightness.dark,
);

final ColorScheme getReadyColorScheme = activeColorScheme.copyWith(
  secondary: Colors.yellow.shade300,
  secondaryVariant: Colors.yellow.shade600,
);

final ColorScheme restColorScheme = activeColorScheme.copyWith(
  secondary: Colors.blue.shade300,
  secondaryVariant: Colors.blue.shade600,
);
