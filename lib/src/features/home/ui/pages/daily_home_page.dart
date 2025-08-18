import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/colors/app_colors.dart';
import 'package:flutter_money_manager/src/features/home/ui/widgets/add_summary_button.dart';
import 'package:flutter_money_manager/src/features/home/ui/widgets/calendar_page.dart';
import 'package:flutter_money_manager/src/features/home/ui/widgets/daily_balance_widget.dart';
import 'package:flutter_money_manager/src/features/home/ui/widgets/home_tab_bar.dart';
import 'package:flutter_money_manager/src/features/home/ui/widgets/summary_content.dart';

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
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SummaryContent()
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(0.60),
                    borderRadius: BorderRadius.circular(12)),
                child: HomeTabBar(tabController: _tabController),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: TabBarView(controller: _tabController, children: const [
                  DailyBalancePage(),
                  CalendarPage(),
                  DailyBalancePage(),
                ]),
              )
            ],
          ),
        ),
        const Positioned(
          bottom: 30,
          right: 30,
          child: AddSummaryButton()
        )
      ],
    );
  }
}
