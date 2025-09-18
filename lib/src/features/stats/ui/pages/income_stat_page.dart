import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/core/styles/container_styles.dart';
import 'package:flutter_money_manager/src/features/stats/domain/entities/report_breakdown.dart';
import 'package:flutter_money_manager/src/features/stats/ui/blocs/stats_bloc.dart';
import 'package:flutter_money_manager/src/features/stats/ui/blocs/stats_event.dart';
import 'package:flutter_money_manager/src/features/stats/ui/blocs/stats_state.dart';
import 'package:flutter_money_manager/src/features/stats/ui/widgets/pie_chart_sample.dart';
import 'package:flutter_money_manager/src/features/stats/ui/widgets/stat_list_items.dart';

class IncomeStatPage extends StatefulWidget {
  const IncomeStatPage({super.key});

  @override
  State<IncomeStatPage> createState() => _IncomeStatPageState();
}

class _IncomeStatPageState extends State<IncomeStatPage> {
  late final StatsBloc _statsBloc;

  @override
  void initState() {
    super.initState();
    _statsBloc = BlocProvider.of<StatsBloc>(context);
    _statsBloc.add(const LoadStatsEvent(type: TransactionTypEnum.income));
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height * 0.50;

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: maxHeight,
        decoration: ContainerStyles.statContainerBoxContainer,
        child: BlocSelector<StatsBloc, StatsState, List<StatBreakdown>>(
          selector: (state) {
            return state.data.stats;
          },
          builder: (context, stats) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                PieChartSample(stats: stats),
                Expanded(
                  child: StatListItems(stats: stats),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
