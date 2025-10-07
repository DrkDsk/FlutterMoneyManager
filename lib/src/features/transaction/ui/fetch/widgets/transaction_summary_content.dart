import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/colors/app_colors.dart';
import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/core/extensions/string_extension.dart';
import 'package:flutter_money_manager/src/features/home/ui/widgets/summary_text.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/monthly_summary.dart';

class TransactionSummaryContent extends StatelessWidget {
  final MonthlySummary summary;

  const TransactionSummaryContent({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SummaryText(
          summaryLabel: TransactionsConstants.kIncomeType.firstUpper(),
          summaryValue: "${summary.income}",
          textValueColor: AppColors.incomeColor,
        ),
        const SizedBox(
          width: 10,
        ),
        SummaryText(
          summaryLabel: TransactionsConstants.kExpenseType.firstUpper(),
          summaryValue: "${summary.expense}",
          textValueColor: AppColors.expenseColor,
        ),
        const SizedBox(
          width: 10,
        ),
        SummaryText(
          summaryLabel: "Total",
          summaryValue: "${summary.total}",
          textValueColor: colorScheme.onPrimary,
        ),
      ],
    );
  }
}
