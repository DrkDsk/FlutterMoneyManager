import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_manager/src/features/home/ui/widgets/add_transaction_button.dart';
import 'package:flutter_money_manager/src/features/home/ui/widgets/calendar_page.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/cubit/get_transactions_list_cubit.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/cubit/get_transactions_list_state.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/widgets/daily_balance_page_widget.dart';
import 'package:flutter_money_manager/src/features/stats/ui/widgets/custom_tab_bar.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/widgets/header_balance_scroll_page.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/widgets/transaction_summary_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;
  late GetTransactionsListCubit _getTransactionsListCubit;

  @override
  void initState() {
    super.initState();
    _getTransactionsListCubit = context.read<GetTransactionsListCubit>();
    final initialIndexMonth = _getTransactionsListCubit.state.indexMonth;
    _pageController = PageController(initialPage: initialIndexMonth);
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);

    Future.microtask(() {
      _getTransactionsListCubit.getTransactions();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _pageController.dispose();
  }

  void leftTap() {
    _getTransactionsListCubit.previousPageIndex();
    final index = _getTransactionsListCubit.state.indexMonth;
    _pageController.jumpToPage(index);
  }

  void rightTap() {
    _getTransactionsListCubit.nextPage();
    final index = _getTransactionsListCubit.state.indexMonth;
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: [
              const SizedBox(height: 10),
              BlocBuilder<GetTransactionsListCubit, GetTransactionListState>(
                builder: (context, state) {
                  return HeaderBalanceScrollPage(
                    monthName: state.monthName,
                    leftTap: leftTap,
                    rightTap: rightTap,
                  );
                },
              ),
              const SizedBox(height: 10),
              Expanded(
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 13,
                  controller: _pageController,
                  onPageChanged: (index) {
                    print("updated");
                    _getTransactionsListCubit.updateIndex(index);

                    _getTransactionsListCubit.getTransactions(
                        monthIndex: index);
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        const TransactionSummaryContent(),
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
                          child: TabBarView(
                              controller: _tabController,
                              children: const [
                                DailyBalancePage(),
                                CalendarPage(),
                                DailyBalancePage(),
                              ]),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const Positioned(bottom: 30, right: 30, child: AddTransactionButton())
      ],
    );
  }
}
