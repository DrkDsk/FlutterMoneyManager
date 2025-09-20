import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/shared/widgets/custom_divider.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_category.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/widgets/transaction_list_item.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({super.key, required this.transactions});

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      separatorBuilder: (_, index) => const CustomDivider(),
      itemBuilder: (context, index) {
        final transaction = transactions[index];

        final transactionCategoryType = transaction.categoryType;
        TransactionCategory? transactionCategory;

        if (transactionCategoryType != null) {
          transactionCategory =
              TransactionCategory.fromString(transactionCategoryType);
        }

        if (transactionCategory == null) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: TransactionListItem(
            type: transaction.type,
            amount: transaction.amount,
            transactionSource: transaction.sourceType,
            category: transactionCategory.name,
            iconAssetCategory: transactionCategory.icon,
          ),
        );
      },
    );
  }
}
