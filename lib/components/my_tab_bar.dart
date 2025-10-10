import 'package:flutter/material.dart';

class MyTabBar extends StatelessWidget {
  final TabController tabController;

  const MyTabBar({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBar(
        controller: tabController,
        tabs: [
          // 1st tab
          Tab(
            icon: Icon(Icons.home),
          ), // Tab

          // 2nd tab
          Tab(
            icon: Icon(Icons.settings),
          ), // Tab

          // 3rd Tab
          Tab(
            icon: Icon(Icons.person),
          ), // Tab
        ],
      ), // TabBar
    ); // Container
  }
}