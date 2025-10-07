import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/styles/container_styles.dart';
import 'package:flutter_money_manager/src/features/stats/domain/entities/report_breakdown.dart';
import 'package:flutter_money_manager/src/features/stats/ui/widgets/pie_chart_sample.dart';
import 'package:flutter_money_manager/src/features/stats/ui/widgets/stat_list_items.dart';

class TopFiveSummaryWidget extends StatelessWidget {
  const TopFiveSummaryWidget({super.key, required this.stats});

  final List<StatBreakdown> stats;

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
          Text("Expense TOP5", style: mediumStyle),
          PieChartSample(stats: stats),
          StatListItems(stats: stats)
        ],
      ),
    );
  }
}
