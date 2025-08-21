import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/colors/app_colors.dart';
import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/core/router/app_router.dart';
import 'package:flutter_money_manager/src/core/shared/home/ui/widgets/custom_app_bar.dart';
import 'package:flutter_money_manager/src/core/shared/home/ui/widgets/custom_numeric_keyboard.dart';
import 'package:flutter_money_manager/src/core/theme/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/blocs/cubit/create_transaction_cubit.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/blocs/cubit/create_transaction_state.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/widgets/bottom_payment_sources.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/widgets/bottom_transaction_category.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/widgets/create_transaction_item.dart';

class CreateTransactionScreen extends StatefulWidget {
  const CreateTransactionScreen({super.key});

  @override
  State<CreateTransactionScreen> createState() =>
      _CreateTransactionScreenState();
}

class _CreateTransactionScreenState extends State<CreateTransactionScreen> {
  late CreateTransactionCubit _createTransactionCubit;
  late AppRouter _router;

  StringBuffer amountValue = StringBuffer();

  @override
  void initState() {
    super.initState();
    _createTransactionCubit = context.read<CreateTransactionCubit>();
    _router = AppRouter.of(context);
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
            onOkSubmit: () => _router.pop(),
            onNumberTap: (number) {
              amountValue.write(number);
              final formatted = formatAmount(amountValue.toString());
              _createTransactionCubit.updateAmount(formatted);
            },
            onBackspace: () {
              final amountString = _createTransactionCubit.state.amount;

              final stringWithOutLast = amountString
                  .substring(0, amountString.length - 1)
                  .replaceAll("\$ ", "")
                  .replaceAll(" ", "");

              amountValue.clear();

              if (stringWithOutLast.isEmpty) {
                _createTransactionCubit.updateAmount(kDefaultAmountValue);
                return;
              }

              _createTransactionCubit.updateAmount("\$ $stringWithOutLast");
            },
          ),
        );
      },
    );
  }

  _showPaymentSources(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FractionallySizedBox(
            heightFactor: 0.4,
            child: BottomPaymentSources(
              onSelectPaymentSource: (paymentSource) {
                _createTransactionCubit.updatePaymentSource(paymentSource);
                _router.pop();
              },
            ));
      },
    );
  }

  _showTransactionsCategories(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return FractionallySizedBox(
            heightFactor: 0.4,
            child: BottomTransactionCategory(
              onSelectCategory: (category) {
                _createTransactionCubit.updateTransactionCategory(category);
                _router.pop();
              },
            ));
      },
    );
  }

  void onTransactionDateChanged() async {
    final today = DateTime.now();
    const defaultDuration = Duration(days: 30);

    final firstDate = today.subtract(defaultDuration);
    final lastDate = today.add(defaultDuration);

    final selectedDate = await showDatePicker(
        context: context,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Colors.blue, // color header
                  onPrimary: Colors.white, // texto header
                  onSurface: Colors.black, // texto días
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue, // color botones
                  ),
                ),
                textTheme: const TextTheme()),
            child: child!,
          );
        },
        firstDate: firstDate,
        lastDate: lastDate);

    _createTransactionCubit.updateAmountDate(selectedDate);
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
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: defaultBorder,
          child: BlocBuilder<CreateTransactionCubit, CreateTransactionState>(
            builder: (context, state) {
              final paymentSource = state.paymentSource;
              final transactionCategory = state.transactionCategory;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                      child: CreateTransactionItem(
                        label: "Date",
                        largeStyle: largeStyle,
                        mediumStyle: mediumStyle,
                        value: state.transactionDate.toString(),
                        onTap: onTransactionDateChanged,
                      ),
                    ),
                    const Divider(
                        height: 20, color: Colors.grey, thickness: 0.2),
                    SizedBox(
                      height: 100,
                      child: CreateTransactionItem(
                          largeStyle: largeStyle,
                          mediumStyle: TextStyle(color: AppColors.expenseColor),
                          label: "Amount",
                          value: state.amount,
                          onTap: () => _showCustomKeyboard(context)),
                    ),
                    const Divider(
                        height: 20, color: Colors.grey, thickness: 0.2),
                    SizedBox(
                      height: 100,
                      child: CreateTransactionItem(
                          label: "Category",
                          onTap: () => _showTransactionsCategories(context),
                          value: "Uncategorized",
                          mediumStyle: mediumStyle,
                          child: transactionCategory == null
                              ? null
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(transactionCategory.name,
                                        style: mediumStyle),
                                    const SizedBox(width: 5),
                                    Image.asset(
                                      transactionCategory.icon,
                                      width: 30,
                                    )
                                  ],
                                )),
                    ),
                    const Divider(
                        height: 20, color: Colors.grey, thickness: 0.2),
                    SizedBox(
                      height: 100,
                      child: CreateTransactionItem(
                          label: "Payment Source",
                          onTap: () => _showPaymentSources(context),
                          value: "Uncategorized",
                          mediumStyle: mediumStyle,
                          child: paymentSource == null
                              ? null
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(paymentSource.name,
                                        style: mediumStyle),
                                    ...[
                                      const SizedBox(width: 5),
                                      Image.asset(
                                        paymentSource.icon,
                                        width: 30,
                                      )
                                    ],
                                  ],
                                )),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
