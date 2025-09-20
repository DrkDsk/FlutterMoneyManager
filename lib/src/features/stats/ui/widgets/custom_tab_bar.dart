import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/styles/container_styles.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar(
      {super.key,
      required this.tabController,
      required this.tabs,
      this.decoration,
      this.onTap,
      this.margin = const EdgeInsets.symmetric(horizontal: 10, vertical: 10)});

  final TabController tabController;
  final List<Widget> tabs;
  final EdgeInsetsGeometry? margin;
  final Decoration? decoration;
  final void Function(int tabIndex)? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final indicatorDecoration = decoration ?? ContainerStyles.kTabBarDecoration;

    return Container(
        height: 40,
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
        decoration: ContainerStyles.kTabBarContainerDecoration,
        child: TabBar(
            onTap: onTap,
            dividerColor: Colors.transparent,
            indicatorSize: TabBarIndicatorSize.tab,
            controller: tabController,
            indicator: indicatorDecoration,
            labelColor: theme.colorScheme.primary,
            tabs: tabs));
  }
}
