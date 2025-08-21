import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/payment_source.dart';

class BottomPaymentSources extends StatelessWidget {
  const BottomPaymentSources({super.key, required this.onSelectPaymentSource});

  final Function(PaymentSource category) onSelectPaymentSource;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 10),
        itemCount: kDefaultPaymentResources.length,
        itemBuilder: (context, index) {
          final paymentSource = kDefaultPaymentResources[index];

          return GestureDetector(
            onTap: () => onSelectPaymentSource(paymentSource),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  paymentSource.icon,
                  height: 50,
                  width: 50,
                ),
                const SizedBox(height: 6),
                Text(
                  paymentSource.name,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(color: theme.colorScheme.primary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis, // 👈 evita cortes feos
                ),
              ],
            ),
          );
        });
  }
}
