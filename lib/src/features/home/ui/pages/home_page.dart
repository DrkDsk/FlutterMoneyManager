import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_manager/src/core/extensions/datetime_extension.dart';
import 'package:flutter_money_manager/src/core/styles/container_styles.dart';
import 'package:flutter_money_manager/src/features/home/ui/widgets/add_transaction_button.dart';
import 'package:flutter_money_manager/src/features/home/ui/widgets/calendar_page.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/calendar/calendar_bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/calendar/calendar_event.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/transactions/transactions_bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/transactions/transactions_event.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/transactions/transactions_state.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/widgets/daily_balance_page.dart';
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
  late TransactionsBloc _transactionsBloc;
  late CalendarBloc _calendarBloc;

  @override
  void initState() {
    super.initState();
    _transactionsBloc = context.read<TransactionsBloc>();
    _calendarBloc = context.read<CalendarBloc>();
    final initialIndexMonth = _transactionsBloc.state.monthIndex;
    _pageController = PageController(initialPage: initialIndexMonth);
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _transactionsBloc.add(const LoadTransactionsByMonth());
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _pageController.dispose();
  }

  void _changeMonth({
    required int daysOffset,
    required int? Function() getIndex,
  }) {
    final index = getIndex();
    if (index == null) return;

    final date = _calendarBloc.state.focusedDate;
    final focusedDate = date.add(Duration(days: daysOffset));
    final newMonthIndex = focusedDate.month;

    _calendarBloc.add(UpdateFocusedDate(focusedDate: focusedDate));

    final titleCalendar = "${focusedDate.monthName} ${focusedDate.year}";
    _calendarBloc.add(UpdateTitleCalendar(titleCalendar: titleCalendar));

    _transactionsBloc.add(UpdateMonth(monthIndex: newMonthIndex));
    _pageController.jumpToPage(newMonthIndex);
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
              BlocBuilder<TransactionsBloc, TransactionsListState>(
                builder: (context, state) {
                  return HeaderBalanceScrollPage(
                    monthName: state.monthName,
                    leftTap: () => _changeMonth(
                        daysOffset: -30, getIndex: _transactionsBloc.prevIndex),
                    rightTap: () => _changeMonth(
                        daysOffset: 30, getIndex: _transactionsBloc.nextIndex),
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
                    _transactionsBloc.add(UpdateMonth(monthIndex: index));
                    _transactionsBloc
                        .add(LoadTransactionsByMonth(month: index));
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
                              Tab(text: "Daily"),
                              Tab(text: "Calendar"),
                              Tab(text: "Summary"),
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
