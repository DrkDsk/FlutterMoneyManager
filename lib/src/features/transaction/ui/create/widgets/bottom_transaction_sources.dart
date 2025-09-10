import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_source.dart';

class BottomTransactionSources extends StatelessWidget {
  const BottomTransactionSources(
      {super.key, required this.onSelectTransactionSource});

  final Function(TransactionSource transactionSource) onSelectTransactionSource;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 10),
        itemCount: TransactionsConstants.kDefaultTransactionSources.length,
        itemBuilder: (context, index) {
          final transactionSource =
              TransactionsConstants.kDefaultTransactionSources[index];

          return GestureDetector(
            onTap: () => onSelectTransactionSource(transactionSource),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  transactionSource.icon,
                  height: 50,
                  width: 50,
                ),
                const SizedBox(height: 6),
                Text(
                  transactionSource.name,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: theme.colorScheme.primary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        });
  }
}
