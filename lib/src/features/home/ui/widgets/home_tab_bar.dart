import 'package:flutter/material.dart';

class HomeTabBar extends StatelessWidget {
  const HomeTabBar({
    super.key,
    required TabController tabController,
  }) : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return TabBar(
        controller: _tabController,
        dividerColor: Colors.transparent,
        onTap: (value) {

        },
        tabs: [
          Text(
            "Daily",
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.primary),
          ),
          Text(
            "Calendar",
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.primary),
          ),
          Text(
            "Summary",
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.primary),
          ),
        ]);
  }
}