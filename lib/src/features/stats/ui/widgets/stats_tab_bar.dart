import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/styles/container_styles.dart';

class StatsTabBar extends StatelessWidget {
  const StatsTabBar({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TabBar(
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        controller: tabController,
        indicator: kTabBarDecoration,
        labelColor: theme.colorScheme.primary,
        tabs: const [Tab(text: "Income"), Tab(text: "Expense")]);
  }
}
