import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/colors/app_colors.dart';
import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/core/extensions/string_extension.dart';
import 'package:flutter_money_manager/src/features/home/ui/widgets/summary_text.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/cubit/get_transactions_list_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/cubit/get_transactions_list_state.dart';

class TransactionSummaryContent extends StatelessWidget {
  const TransactionSummaryContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<GetTransactionsListCubit, GetTransactionListState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SummaryText(
              summaryLabel: kIncomeType.firstUpper(),
              summaryValue: "${state.income}",
              textValueColor: AppColors.incomeColor,
            ),
            const SizedBox(
              width: 10,
            ),
            SummaryText(
              summaryLabel: kExpenseType.firstUpper(),
              summaryValue: "${state.expense}",
              textValueColor: AppColors.expenseColor,
            ),
            const SizedBox(
              width: 10,
            ),
            SummaryText(
              summaryLabel: "Total",
              summaryValue: "${state.total}",
              textValueColor: colorScheme.onPrimary,
            ),
          ],
        );
      },
    );
  }
}
