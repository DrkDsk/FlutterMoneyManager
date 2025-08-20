import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_category.dart';

class BottomPaymentSources extends StatelessWidget {
  const BottomPaymentSources({super.key, required this.onSelectCategory});

  final Function(Transactioncategory category) onSelectCategory;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 40, childAspectRatio: 0.85),
          itemCount: kDefaultTransactionsCategories.length,
          itemBuilder: (context, index) {
            final transactionCategory = kDefaultTransactionsCategories[index];

            return GestureDetector(
              onTap: () => onSelectCategory(transactionCategory),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    transactionCategory.icon,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    transactionCategory.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis, // 👈 evita cortes feos
                  ),
                ],
              ),
            );
          }),
    );
  }
}
