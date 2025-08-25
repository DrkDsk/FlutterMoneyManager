import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/styles/container_styles.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar(
      {super.key,
      required this.tabController,
      required this.tabs,
      this.margin = const EdgeInsets.symmetric(horizontal: 10, vertical: 10)});

  final TabController tabController;
  final List<Widget> tabs;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
        height: 40,
        margin: margin,
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
        decoration: kTabBarContainerDecoration,
        child: TabBar(
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            controller: tabController,
            indicator: kTabBarDecoration,
            labelColor: theme.colorScheme.primary,
            tabs: tabs));
  }
}
