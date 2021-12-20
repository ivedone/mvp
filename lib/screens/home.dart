import 'package:flutter/material.dart';
import 'package:mvp/components/do_routine/control_panel/control_panel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
          title: Text('Home', style: Theme.of(context).textTheme.subtitle1)),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(child: Container()),
        const ControlPanelWidget(),
      ]),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.primaryVariant,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ]),
    );
  }
}
