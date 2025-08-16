import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/features/ui/widgets/daily_balance_widget.dart';
import 'package:flutter_money_manager/src/features/ui/widgets/home_tab_bar.dart';
import 'package:flutter_money_manager/src/features/ui/widgets/custom_bottom_app_bar.dart';
import 'package:flutter_money_manager/src/features/ui/widgets/summary_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: const CustomBottomAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SummaryContent(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.purpleAccent.shade200.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12)),
              child: HomeTabBar(tabController: _tabController),
            ),
            Expanded(
              child: TabBarView(controller: _tabController, children: const [
                DailyBalanceWidget(),
                DailyBalanceWidget(),
                DailyBalanceWidget(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
