import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/calendar/calendar_bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/summary/summary_bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/summary/summary_event.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/summary/summary_state.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/widgets/monthly_summary_comparison_widget.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/widgets/top_five_summary_widget.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({super.key});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  late final SummaryBloc _summaryBloc;
  late final CalendarBloc _calendarBloc;

  @override
  void initState() {
    super.initState();
    _summaryBloc = BlocProvider.of<SummaryBloc>(context);
    _calendarBloc = BlocProvider.of<CalendarBloc>(context);
    final focusedDate = _calendarBloc.state.focusedDate;
    final month = focusedDate.month;
    final previousMonthIndex =
        focusedDate.subtract(const Duration(days: 30)).month;
    final year = focusedDate.year;

    _summaryBloc.add(UpdateSelectedDate(year: year, month: month));

    _summaryBloc.add(FetchSummaryEvent(previousMonthIndex: previousMonthIndex));

    _summaryBloc.add(const FetchTopFiveExpense());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: BlocBuilder<SummaryBloc, SummaryState>(
        builder: (context, state) {
          final currentSummary = state.currentMonthlySummary;
          final lastSummary = state.lastMonthlySummary;
          final topFiveExpense = state.topFiveSummary.expenseStats;

          return Column(
            children: [
              MonthlySummaryComparisonWidget(
                label: "Last Month Comparison",
                currentSummary: currentSummary,
                lastMonthSummary: lastSummary,
              ),
              const SizedBox(height: 10),
              TopFiveSummaryWidget(stats: topFiveExpense)
            ],
          );
        },
      ),
    );
  }
}
