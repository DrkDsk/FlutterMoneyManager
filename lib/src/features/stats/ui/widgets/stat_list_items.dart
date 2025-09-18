import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/colors/category_colors.dart';
import 'package:flutter_money_manager/src/features/stats/domain/entities/report_breakdown.dart';
import 'package:flutter_money_manager/src/features/stats/ui/widgets/indicator.dart';

class StatListItems extends StatelessWidget {
  final List<StatBreakdown> stats;

  const StatListItems({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ListView.builder(
          itemCount: stats.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final source = stats[index].source;

            return Indicator(
                color: CategoryColors.getCategoryColor(source.toLowerCase()),
                text: source,
                isSquare: true);
          }),
    );
  }
}
