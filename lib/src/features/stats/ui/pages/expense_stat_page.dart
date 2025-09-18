import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/features/stats/ui/blocs/stats_bloc.dart';
import 'package:flutter_money_manager/src/features/stats/ui/blocs/stats_event.dart';
import 'package:flutter_money_manager/src/features/stats/ui/blocs/stats_state.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/widgets/transactions_list.dart';
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
    return Column(
      children: [
        BlocBuilder<StatsBloc, StatsState>(
          builder: (context, state) {
            return const PieChartSample();
          },
        ),
        const Expanded(
            child: TransactionsList(
          transactions: [],
        ))
      ],
    );
  }
}
