import 'package:flutter/material.dart';

class HomeTabBar extends StatelessWidget {
  const HomeTabBar({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
        controller: _tabController,
        dividerColor: Colors.transparent,
        onTap: (value) {

        },
        tabs: const [
          Text(
            "Daily",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            "Daily",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            "Daily",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ]);
  }
}