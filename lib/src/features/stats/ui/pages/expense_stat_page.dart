import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_manager/src/core/colors/category_colors.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/core/styles/container_styles.dart';
import 'package:flutter_money_manager/src/features/stats/domain/entities/report_breakdown.dart';
import 'package:flutter_money_manager/src/features/stats/ui/blocs/stats_bloc.dart';
import 'package:flutter_money_manager/src/features/stats/ui/blocs/stats_event.dart';
import 'package:flutter_money_manager/src/features/stats/ui/blocs/stats_state.dart';
import 'package:flutter_money_manager/src/features/stats/ui/widgets/indicator.dart';
import 'package:flutter_money_manager/src/features/stats/ui/widgets/pie_chart_sample.dart';

class ExpenseStatPage extends StatefulWidget {
  const ExpenseStatPage({super.key});

  @override
  State<ExpenseStatPage> createState() => _ExpenseStatPageState();
}

class _ExpenseStatPageState extends State<ExpenseStatPage> {
  late final StatsBloc _statsBloc;

  @override
  void initState() {
    super.initState();
    _statsBloc = BlocProvider.of<StatsBloc>(context);
    _statsBloc.add(const LoadStatsEvent(type: TransactionTypEnum.expense));
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height * 0.50;

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: maxHeight,
        decoration: ContainerStyles.statContainerBoxContainer,
        child: Column(
          children: [
            const PieChartSample(),
            BlocSelector<StatsBloc, StatsState, List<StatBreakdown>>(
                selector: (state) {
              return state.data.reports;
            }, builder: (context, reports) {
              return Expanded(
                  child: ListView.builder(
                      itemCount: reports.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final source = reports[index].source;

                        return Indicator(
                            color: CategoryColors.getCategoryColor(
                                source.toLowerCase()),
                            text: source,
                            isSquare: true);
                      }));
            })
          ],
        ),
      ),
    );
  }
}
