import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/core/extensions/string_extension.dart';
import 'package:flutter_money_manager/src/core/styles/container_styles.dart';
import 'package:flutter_money_manager/src/features/stats/domain/entities/report_breakdown.dart';
import 'package:flutter_money_manager/src/features/stats/ui/widgets/pie_chart_sample.dart';
import 'package:flutter_money_manager/src/features/stats/ui/widgets/stat_list_items.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/summary/summary_bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/summary/summary_event.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/summary/summary_state.dart';

class TopFiveSummaryWidget extends StatefulWidget {
  const TopFiveSummaryWidget({super.key, required this.stats});

  final List<StatBreakdown> stats;

  @override
  State<TopFiveSummaryWidget> createState() => _TopFiveSummaryWidgetState();
}

class _TopFiveSummaryWidgetState extends State<TopFiveSummaryWidget> {
  late final SummaryBloc _summaryBloc;

  @override
  void initState() {
    super.initState();
    _summaryBloc = BlocProvider.of<SummaryBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediumStyle = theme.textTheme.bodyMedium;

    return Container(
      decoration: ContainerStyles.kWidgetRoundedDecoration,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocSelector<SummaryBloc, SummaryState, String>(
                selector: (state) {
                  if (state.selectedTypeForChart ==
                      TransactionTypEnum.expense) {
                    return TransactionsConstants.kExpenseType.firstUpper();
                  }
                  return TransactionsConstants.kIncomeType.firstUpper();
                },
                builder: (context, prefix) {
                  return Text("$prefix TOP5", style: mediumStyle);
                },
              ),
              PopupMenuButton<TransactionTypEnum>(
                onSelected: (value) =>
                    _summaryBloc.add(UpdateTopFiveType(type: value)),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: TransactionTypEnum.income,
                      child:
                          Text(TransactionsConstants.kIncomeType.firstUpper()),
                    ),
                    PopupMenuItem(
                      value: TransactionTypEnum.expense,
                      child:
                          Text(TransactionsConstants.kExpenseType.firstUpper()),
                    ),
                  ];
                },
              )
            ],
          ),
          PieChartSample(stats: widget.stats),
          StatListItems(stats: widget.stats)
        ],
      ),
    );
  }
}
