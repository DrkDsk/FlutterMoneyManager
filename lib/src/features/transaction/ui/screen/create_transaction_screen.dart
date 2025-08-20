import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/colors/app_colors.dart';
import 'package:flutter_money_manager/src/core/shared/home/ui/widgets/custom_app_bar.dart';
import 'package:flutter_money_manager/src/core/shared/home/ui/widgets/custom_numeric_keyboard.dart';
import 'package:flutter_money_manager/src/core/theme/styles.dart';

class CreateTransactionScreen extends StatefulWidget {
  const CreateTransactionScreen({super.key});

  @override
  State<CreateTransactionScreen> createState() =>
      _CreateTransactionScreenState();
}

class _CreateTransactionScreenState extends State<CreateTransactionScreen> {
  static const String defaultAmountValue = "\$ 0";

  late FocusNode _amountFocusNode;
  late FocusNode _paymentFocusNode;
  late TextEditingController _noteController;
  late TextEditingController _amountController;

  StringBuffer amountValue = StringBuffer("0");
  String amountString = defaultAmountValue;

  @override
  void initState() {
    _noteController = TextEditingController();
    _amountController = TextEditingController(text: defaultAmountValue);
    _amountFocusNode = FocusNode();
    _paymentFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _noteController.dispose();
    _amountController.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }

  String formatAmount(String value) {
    String cleaned = value.replaceAll(RegExp(r'[^0-9]'), '');

    if (cleaned.isEmpty || int.tryParse(cleaned) == 0) {
      return "0";
    }

    cleaned = int.parse(cleaned).toString();

    return "\$ $cleaned";
  }

  void _showCustomKeyboard(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.5,
          child: CustomNumericKeyboard(
            onNumberTap: (number) {
              amountValue.write(number);
              setState(() {
                final formatted = formatAmount(amountValue.toString());
                amountString = formatted;
              });
            },
            onBackspace: () {
              final stringWithOutLast = amountString
                  .substring(0, amountString.length - 1)
                  .replaceAll("\$ ", "")
                  .replaceAll(" ", "");

              if (stringWithOutLast.isEmpty) {
                setState(() {
                  amountValue.clear();
                  amountString = defaultAmountValue;
                });

                return;
              }

              setState(() {
                amountString = "\$ $stringWithOutLast";
              });
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final mediumStyle = theme.textTheme.bodyLarge
        ?.copyWith(fontSize: 20, fontWeight: FontWeight.w400);
    final largeStyle = theme.textTheme.bodyMedium?.copyWith(fontSize: 20);

    return Scaffold(
      appBar: const CustomAppBar(),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.turquoise,
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                    child: Text("Save",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: theme.colorScheme.primary))),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: theme.colorScheme.secondary)),
              child: Center(
                  child: Text("Continue",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: theme.colorScheme.secondary))),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: defaultBorder,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Date", style: largeStyle),
                      GestureDetector(
                          onTap: () {
                            final today = DateTime.now();
                            const defaultDuration = Duration(days: 30);

                            final firstDate = today.subtract(defaultDuration);
                            final lastDate = today.add(defaultDuration);

                            showDatePicker(
                                context: context,
                                firstDate: firstDate,
                                lastDate: lastDate);
                          },
                          child: Text("Aug 18, 2025", style: mediumStyle))
                    ],
                  ),
                  const Divider(height: 20, color: Colors.grey, thickness: 0.2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Amount"),
                      GestureDetector(
                        onTap: () => _showCustomKeyboard(context),
                        child: Text(
                          amountString,
                          style: TextStyle(color: AppColors.expenseColor),
                        ),
                      )
                    ],
                  ),
                  const Divider(height: 20, color: Colors.grey, thickness: 0.2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Category", style: largeStyle),
                      Text("Uncategorized", style: mediumStyle)
                    ],
                  ),
                  const Divider(height: 20, color: Colors.grey, thickness: 0.2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Payment Source", style: largeStyle),
                      Text("None", style: mediumStyle)
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: defaultBorder,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                readOnly: true,
                focusNode: _paymentFocusNode,
                onTap: () => _showCustomKeyboard(context),
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            )
          ],
        ),
      ),
    );
  }
}
