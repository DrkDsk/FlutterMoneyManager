import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/colors/app_colors.dart';
import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/core/extensions/string_extension.dart';
import 'package:flutter_money_manager/src/features/home/ui/widgets/summary_text.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/monthly_summary.dart';

class TransactionSummaryContent extends StatelessWidget {
  final MonthlySummary summary;
  final bool showPrefix;

  const TransactionSummaryContent(
      {super.key, required this.summary, this.showPrefix = false});

  String getPrefix(num value, {required bool showPrefix}) {
    if (!showPrefix || value == 0) return "";
    return value.isNegative ? "-" : "+";
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final prefixIncome = getPrefix(summary.income, showPrefix: showPrefix);
    final prefixExpense = getPrefix(summary.expense, showPrefix: showPrefix);
    final prefixTotal = getPrefix(summary.total, showPrefix: showPrefix);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SummaryText(
          summaryLabel: TransactionsConstants.kIncomeType.firstUpper(),
          summaryValue: "${summary.income.abs()}",
          prefix: prefixIncome,
          textValueColor: AppColors.incomeColor,
        ),
        const SizedBox(
          width: 10,
        ),
        SummaryText(
          summaryLabel: TransactionsConstants.kExpenseType.firstUpper(),
          prefix: prefixExpense,
          summaryValue: "${summary.expense.abs()}",
          textValueColor: AppColors.expenseColor,
        ),
        const SizedBox(
          width: 10,
        ),
        SummaryText(
          summaryLabel: "Total",
          prefix: prefixTotal,
          summaryValue: "${summary.total.abs()}",
          textValueColor: colorScheme.onPrimary,
        ),
      ],
    );
  }
}
