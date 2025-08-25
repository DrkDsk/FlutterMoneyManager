import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/features/home/ui/widgets/add_transaction_button.dart';
import 'package:flutter_money_manager/src/features/home/ui/widgets/calendar_page.dart';
import 'package:flutter_money_manager/src/features/home/ui/widgets/daily_balance_widget.dart';
import 'package:flutter_money_manager/src/features/stats/ui/widgets/custom_tab_bar.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/widgets/transaction_summary_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: [
              const SizedBox(height: 60),
              const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: TransactionSummaryContent()),
              const SizedBox(height: 20),
              CustomTabBar(
                  tabController: _tabController,
                  margin: EdgeInsets.zero,
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
                  ]),
              const SizedBox(height: 20),
              Expanded(
                child: TabBarView(controller: _tabController, children: const [
                  DailyBalancePage(),
                  CalendarPage(),
                  DailyBalancePage(),
                ]),
              ),
            ],
          ),
        ),
        const Positioned(bottom: 30, right: 30, child: AddTransactionButton())
      ],
    );
  }
}
