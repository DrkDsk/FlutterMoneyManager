import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/colors/app_colors.dart';
import 'package:flutter_money_manager/src/features/home/ui/widgets/summary_text.dart';

class TransactionSummaryContent extends StatelessWidget {
  const TransactionSummaryContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        SummaryText(
          summaryLabel: "Income",
          summaryValue: "840.00",
          textValueColor: AppColors.incomeColor,
        ),
        const SizedBox(
          width: 10,
        ),
        SummaryText(
          summaryLabel: "Expense",
          summaryValue: "560.00",
          textValueColor: AppColors.expenseColor,
        ),
        const SizedBox(
          width: 10,
        ),
        SummaryText(
          summaryLabel: "Total",
          summaryValue: "280.00",
          textValueColor: colorScheme.onPrimary,
        ),
        const SizedBox(
          width: 10,
        ),
        SummaryText(
          summaryLabel: "Balance",
          summaryValue: "280.00",
          textValueColor: colorScheme.onPrimary,
        ),
      ],
    );
  }
}