import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/styles/container_styles.dart';
import 'package:flutter_money_manager/src/features/stats/ui/pages/expense_stat_page.dart';
import 'package:flutter_money_manager/src/features/stats/ui/pages/income_stat_page.dart';
import 'package:flutter_money_manager/src/features/stats/ui/widgets/stats_tab_bar.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
            decoration: kTabBarContainerDecoration,
            child: StatsTabBar(tabController: _tabController)),
        Expanded(
            child: TabBarView(
                controller: _tabController,
                children: const [IncomeStatPage(), ExpenseStatPage()])),
      ],
    );
  }
}
