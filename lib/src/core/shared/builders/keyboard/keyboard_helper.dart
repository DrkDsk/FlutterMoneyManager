import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/shared/widgets/custom_numeric_keyboard.dart';

class KeyboardHelper {
  static void showCustomKeyboard({
    required BuildContext context,
    required void Function(int updatedAmount) onAmountChanged,
    required VoidCallback onOkSubmit,
    required String currentAmount,
    required StringBuffer amountValue,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(),
      builder: (context) {
        return CustomNumericKeyboard(
          onOkSubmit: onOkSubmit,
          onNumberTap: (number) {
            amountValue.write(number);
            final updatedAmount = int.tryParse(amountValue.toString()) ?? 0;
            onAmountChanged(updatedAmount);
          },
          onBackspace: () {
            final value = amountValue.toString();
            if (value.length <= 1) {
              onAmountChanged(0);
              amountValue.clear();
              return;
            }

            final updatedString = value.substring(0, value.length - 1);
            final updatedAmount = int.tryParse(updatedString) ?? 0;

            amountValue
              ..clear()
              ..write(updatedString);

            onAmountChanged(updatedAmount);
          },
        );
      },
    );
  }
}
