import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/features/stats/ui/widgets/pie_chart_sample.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [PieChartSample()],
    );
  }
}
