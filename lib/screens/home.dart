import 'package:flutter/material.dart';
import 'package:mvp/components/control_panel/control_panel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Home', style: Theme.of(context).textTheme.subtitle1)),
      body: Column(children: [
        Expanded(child: Container()),
        const ControlPanelWidget(),
      ]),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      ]),
    );
  }
}
