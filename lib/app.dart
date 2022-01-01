import 'package:flutter/material.dart';

import 'package:mvp/screens/home.dart';
import 'package:mvp/theme/theme.dart';

class IvedoneApp extends StatelessWidget {
  const IvedoneApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ivedone',
        theme: activeTheme,
        debugShowCheckedModeBanner: false,
        home: const HomeScreen());
  }
}
