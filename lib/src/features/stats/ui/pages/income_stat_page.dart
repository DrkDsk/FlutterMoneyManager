import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/features/stats/ui/blocs/stats_bloc.dart';
import 'package:flutter_money_manager/src/features/stats/ui/blocs/stats_event.dart';
import 'package:flutter_money_manager/src/features/stats/ui/widgets/pie_chart_sample.dart';

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
    return const Column(
      children: [
        PieChartSample(),
      ],
    );
  }
}
