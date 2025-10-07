import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_manager/src/core/styles/container_styles.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/summary/summary_bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/summary/summary_event.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/summary/summary_state.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/transactions/transactions_bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/widgets/monthly_summary_comparison_widget.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({super.key});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  late final SummaryBloc _summaryBloc;
  late final TransactionsBloc _transactionsBloc;

  @override
  void initState() {
    super.initState();
    _summaryBloc = BlocProvider.of<SummaryBloc>(context);
    _transactionsBloc = BlocProvider.of<TransactionsBloc>(context);
    final monthIndex = _transactionsBloc.state.monthIndex;
    _summaryBloc.add(FetchSummaryEvent(currentMonthIndex: monthIndex));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: BlocBuilder<SummaryBloc, SummaryState>(
        builder: (context, state) {
          final currentSummary = state.currentMonthlySummary;
          final lastSummary = state.lastMonthlySummary;

          return Column(
            children: [
              Container(
                decoration: ContainerStyles.kWidgetRoundedDecoration,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                child: MonthlySummaryComparisonWidget(
                  label: "Last Month Comparison",
                  currentSummary: currentSummary,
                  lastMonthSummary: lastSummary,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
