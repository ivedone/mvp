import 'package:flutter/material.dart';
import 'package:mvp/components/bottom_navbar.dart';
import 'package:mvp/components/do_routine/control_panel/control_panel.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(title: const Text('Profile')),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [Expanded(child: Container()), const ControlPanelWidget()]),
      bottomNavigationBar: const BottomNavbar(currentIndex: 2),
    );
  }
}
