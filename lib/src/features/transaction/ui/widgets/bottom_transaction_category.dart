import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_category.dart';

class BottomTransactionCategory extends StatelessWidget {
  final Function(TransactionCategory category) onSelectCategory;

  const BottomTransactionCategory({super.key, required this.onSelectCategory});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 40, childAspectRatio: 0.85),
        itemCount: kDefaultTransactionsCategory.length,
        itemBuilder: (context, index) {
          final category = kDefaultTransactionsCategory[index];

          return GestureDetector(
            onTap: () => onSelectCategory(category),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  category.icon,
                ),
                const SizedBox(height: 6),
                Text(
                  category.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis, // 👈 evita cortes feos
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
