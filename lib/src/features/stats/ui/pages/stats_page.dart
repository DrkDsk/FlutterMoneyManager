import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/core/extensions/datetime_extension.dart';
import 'package:flutter_money_manager/src/core/extensions/string_extension.dart';
import 'package:flutter_money_manager/src/core/styles/container_styles.dart';
import 'package:flutter_money_manager/src/features/stats/ui/blocs/stats_bloc.dart';
import 'package:flutter_money_manager/src/features/stats/ui/blocs/stats_event.dart';
import 'package:flutter_money_manager/src/features/stats/ui/blocs/stats_state.dart';
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
  late final PageController _pageController;
  late final CalendarBloc _calendarBloc;
  late final TransactionsBloc _transactionsBloc;
  late final StatsBloc _statsBloc;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _pageController = PageController(initialPage: 0);
    _calendarBloc = BlocProvider.of<CalendarBloc>(context);
    _transactionsBloc = BlocProvider.of<TransactionsBloc>(context);
    _statsBloc = BlocProvider.of<StatsBloc>(context);
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

  void onPageChanged(int index) {
    _transactionsBloc.add(UpdateMonth(monthIndex: index));
    _transactionsBloc.add(LoadTransactionsByMonth(month: index));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: BlocBuilder<TransactionsBloc, TransactionsState>(
        builder: (context, state) {
          final summary = state.summary;

          return Column(
            children: [
              const SizedBox(height: 10),
              HeaderBalanceScrollPage(
                monthName: state.monthName,
                leftTap: () => _changeMonth(
                    daysOffset: -30, getIndex: _transactionsBloc.prevIndex),
                rightTap: () => _changeMonth(
                    daysOffset: 30, getIndex: _transactionsBloc.nextIndex),
              ),
              Expanded(
                  child: PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 13,
                controller: _pageController,
                onPageChanged: onPageChanged,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      TransactionSummaryContent(summary: summary),
                      const SizedBox(height: 10),
                      BlocSelector<StatsBloc, StatsState, Decoration?>(
                        selector: (state) {
                          final isIncomeTransaction =
                              state.type == TransactionTypEnum.income;

                          return isIncomeTransaction
                              ? ContainerStyles.incomeDecoration
                              : ContainerStyles.expenseDecoration;
                        },
                        builder: (context, indicatorDecoration) {
                          return CustomTabBar(
                              decoration: indicatorDecoration,
                              tabController: _tabController,
                              onTap: (tabIndex) => _statsBloc.add(
                                  UpdateTransactionType(tabIndex: tabIndex)),
                              tabs: [
                                Tab(
                                    text: TransactionsConstants.kIncomeType
                                        .firstUpper()),
                                Tab(
                                    text: TransactionsConstants.kExpenseType
                                        .firstUpper())
                              ]);
                        },
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: TabBarView(
                            controller: _tabController,
                            children: const [
                              IncomeStatPage(),
                              ExpenseStatPage()
                            ]),
                      ),
                    ],
                  );
                },
              )),
            ],
          );
        },
      ),
    );
  }
}
