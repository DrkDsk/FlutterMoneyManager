import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/colors/app_colors.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/monthly_summary.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/widgets/transaction_summary_content.dart';

class MonthlySummaryComparisonWidget extends StatelessWidget {
  final MonthlySummary lastMonthSummary;
  final MonthlySummary currentSummary;
  final String label;

  const MonthlySummaryComparisonWidget(
      {super.key,
      required this.label,
      required this.lastMonthSummary,
      required this.currentSummary});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediumStyle = theme.textTheme.bodyMedium;

    return Column(
      children: [
        Text(label, style: mediumStyle),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Text("Income"),
                Text("\$${lastMonthSummary.income}",
                    style: mediumStyle?.copyWith(color: AppColors.onPrimary))
              ],
            ),
            Column(
              children: [
                const Text("Expense"),
                Text("\$${lastMonthSummary.expense}",
                    style: mediumStyle?.copyWith(color: AppColors.onPrimary))
              ],
            ),
            Column(
              children: [
                const Text("Total"),
                Text("\$${lastMonthSummary.total}",
                    style: mediumStyle?.copyWith(color: AppColors.onPrimary))
              ],
            ),
          ],
        ),
        TransactionSummaryContent(summary: currentSummary)
      ],
    );
  }
}
