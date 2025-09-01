import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/widgets/transactions_list.dart';
import 'package:flutter_money_manager/src/features/stats/ui/widgets/pie_chart_sample.dart';

class IncomeStatPage extends StatelessWidget {
  const IncomeStatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [PieChartSample(), Expanded(child: TransactionsList())],
    );
  }
}
