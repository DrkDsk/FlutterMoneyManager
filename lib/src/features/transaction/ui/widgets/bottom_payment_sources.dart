import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/payment_source.dart';

class BottomPaymentSources extends StatelessWidget {
  const BottomPaymentSources({super.key, required this.onSelectPaymentSource});

  final Function(PaymentSource category) onSelectPaymentSource;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 40, childAspectRatio: 0.85),
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
                  ),
                  const SizedBox(height: 6),
                  Text(
                    paymentSource.name,
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
