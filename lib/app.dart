import 'package:flutter/material.dart';
import 'package:mvp/screens/profile.dart';
import 'package:mvp/theme/theme.dart';

class IvedoneApp extends StatelessWidget {
  const IvedoneApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ivedone',
        theme: activeTheme,
        home: const ProfileScreen());
  }
}
