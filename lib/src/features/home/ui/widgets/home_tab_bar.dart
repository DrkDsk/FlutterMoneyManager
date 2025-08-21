import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/styles/container_styles.dart';

class HomeTabBar extends StatelessWidget {
  const HomeTabBar({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: kTabBarDecoration,
        controller: _tabController,
        onTap: (value) {},
        tabs: const [
          Text(
            "Daily",
          ),
          Text(
            "Calendar",
          ),
          Text(
            "Summary",
          ),
        ]);
  }
}
