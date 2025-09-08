import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/core/extensions/datetime_extension.dart';
import 'package:flutter_money_manager/src/core/extensions/string_extension.dart';
import 'package:flutter_money_manager/src/features/stats/ui/pages/expense_stat_page.dart';
import 'package:flutter_money_manager/src/features/stats/ui/pages/income_stat_page.dart';
import 'package:flutter_money_manager/src/features/stats/ui/widgets/custom_tab_bar.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/calendar/calendar_bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/calendar/calendar_event.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/transactions/transactions_bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/transactions/transactions_event.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/transactions/transactions_state.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/widgets/header_balance_scroll_page.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/widgets/transaction_summary_content.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> with TickerProviderStateMixin {
  late final TabController _tabController;
  late PageController _pageController;
  late CalendarBloc _calendarBloc;
  late TransactionsBloc _transactionsBloc;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _pageController = PageController(initialPage: 0);
    _calendarBloc = context.read<CalendarBloc>();
    _transactionsBloc = context.read<TransactionsBloc>();
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
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
          Expanded(
              child: PageView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 13,
            controller: _pageController,
            onPageChanged: (index) {
              _transactionsBloc.add(UpdateMonth(monthIndex: index));
              _transactionsBloc.add(LoadTransactionsByMonth(monthIndex: index));
            },
            itemBuilder: (context, index) {
              return Column(
                children: [
                  const TransactionSummaryContent(),
                  const SizedBox(height: 10),
                  CustomTabBar(
                      tabController: _tabController,
                      margin: EdgeInsets.zero,
                      tabs: [
                        Tab(text: kIncomeType.firstUpper()),
                        Tab(text: kExpenseType.firstUpper())
                      ]),
                  const SizedBox(height: 10),
                  Expanded(
                    child: TabBarView(
                        controller: _tabController,
                        children: const [IncomeStatPage(), ExpenseStatPage()]),
                  ),
                ],
              );
            },
          )),
        ],
      ),
    );
  }
}
