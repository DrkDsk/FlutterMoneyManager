import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/features/stats/ui/pages/expense_stat_page.dart';
import 'package:flutter_money_manager/src/features/stats/ui/pages/income_stat_page.dart';
import 'package:flutter_money_manager/src/features/stats/ui/widgets/custom_tab_bar.dart';

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
        CustomTabBar(
            tabController: _tabController,
            tabs: const [Tab(text: "Income"), Tab(text: "Expense")]),
        Expanded(
            child: TabBarView(
                controller: _tabController,
                children: const [IncomeStatPage(), ExpenseStatPage()])),
      ],
    );
  }
}
