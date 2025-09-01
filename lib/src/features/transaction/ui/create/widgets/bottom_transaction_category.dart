import 'package:flutter/material.dart';

import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_source.dart';

class BottomTransactionCategory extends StatelessWidget {
  final Function(TransactionSource category) onSelectCategory;
  final List<TransactionSource> items;

  const BottomTransactionCategory(
      {super.key, required this.onSelectCategory, required this.items});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 10),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final category = items[index];

        return GestureDetector(
          onTap: () => onSelectCategory(category),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                category.icon,
                height: 50,
                width: 50,
              ),
              const SizedBox(height: 6),
              Text(
                category.name,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: theme.colorScheme.primary),
                maxLines: 2,
                overflow: TextOverflow.ellipsis, // 👈 evita cortes feos
              ),
            ],
          ),
        );
      },
    );
  }
}
