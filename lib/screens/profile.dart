import 'package:flutter/material.dart';
import 'package:mvp/components/bottom_navbar.dart';
import 'package:mvp/components/do_routine/control_panel/control_panel.dart';
import 'package:mvp/components/profile/grid.dart';
import 'package:mvp/components/profile/header/header.dart';
import 'package:mvp/services/profile.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
          centerTitle: false,
          title: Selector<Profile, String>(
              selector: (_, profile) => profile.user.handle,
              builder: (_, handle, __) =>
                  Text(handle, style: Theme.of(context).textTheme.headline6)),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
          ]),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const HeaderWidget(),
        TabBar(controller: _controller, tabs: const [
          Tab(icon: Icon(Icons.list_rounded)),
          Tab(icon: Icon(Icons.favorite)),
        ]),
        Expanded(
            child: TabBarView(controller: _controller, children: const [
          RoutineGridWidget(),
          Material(color: Colors.red, child: Center(child: Text('Library'))),
        ])),
        const ControlPanelWidget(),
      ]),
      bottomNavigationBar: const BottomNavbar(currentIndex: 2),
    );
  }
}
