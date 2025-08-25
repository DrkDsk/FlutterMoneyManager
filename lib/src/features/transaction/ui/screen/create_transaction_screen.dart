import 'package:flutter/material.dart';
import 'package:flutter_money_manager/src/core/colors/app_colors.dart';
import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/core/extensions/color_extension.dart';
import 'package:flutter_money_manager/src/core/extensions/datetime_extension.dart';
import 'package:flutter_money_manager/src/core/router/app_router.dart';
import 'package:flutter_money_manager/src/core/shared/widgets/custom_app_bar.dart';
import 'package:flutter_money_manager/src/core/shared/widgets/custom_numeric_keyboard.dart';
import 'package:flutter_money_manager/src/core/shared/theme/styles.dart';
import 'package:flutter_money_manager/src/features/stats/ui/widgets/custom_tab_bar.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/blocs/cubit/create_transaction_cubit.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/blocs/cubit/create_transaction_state.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/widgets/bottom_transaction_sources.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/widgets/bottom_transaction_category.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/widgets/create_transaction_bottom_appbar.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/widgets/create_transaction_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateTransactionScreen extends StatefulWidget {
  const CreateTransactionScreen({super.key});

  @override
  State<CreateTransactionScreen> createState() =>
      _CreateTransactionScreenState();
}

class _CreateTransactionScreenState extends State<CreateTransactionScreen>
    with TickerProviderStateMixin {
  late CreateTransactionCubit _createTransactionCubit;
  late AppRouter _router;
  late TabController _transactionTypeTabController;

  StringBuffer amountValue = StringBuffer();

  @override
  void initState() {
    super.initState();
    _createTransactionCubit = context.read<CreateTransactionCubit>();
    _router = AppRouter.of(context);
    _transactionTypeTabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _transactionTypeTabController.dispose();
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
      shape: const RoundedRectangleBorder(),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.4,
          child: Container(
            color: AppColors.onPrimary.customOpacity(0.85),
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

                if (stringWithOutLast.isEmpty) {
                  _createTransactionCubit.updateAmount(kDefaultAmountValue);
                  amountValue.clear();
                  return;
                }

                amountValue.clear();
                amountValue.write(stringWithOutLast);
                _createTransactionCubit.updateAmount("\$ $stringWithOutLast");
              },
            ),
          ),
        );
      },
    );
  }

  _showTransactionSources(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(),
      builder: (context) {
        return FractionallySizedBox(
            heightFactor: 0.4,
            child: Container(
              color: AppColors.keyboardBackgroundColor,
              child: BottomTransactionSources(
                onSelectTransactionSource: (transactionSource) {
                  _createTransactionCubit
                      .updateTransactionSource(transactionSource);
                  _router.pop();
                },
              ),
            ));
      },
    );
  }

  _showTransactionsCategories(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(),
      builder: (context) {
        return Container(
          color: AppColors.keyboardBackgroundColor,
          child: FractionallySizedBox(
              heightFactor: 0.4,
              child: BottomTransactionCategory(
                onSelectCategory: (category) {
                  _createTransactionCubit.updateTransactionCategory(category);
                  _router.pop();
                },
              )),
        );
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

  void _handleSaveTransaction() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      bottomNavigationBar: CreateTransactionBottomAppBar(
        onTap: _handleSaveTransaction,
      ),
      body: SafeArea(
        child: Column(
          children: [
            BlocSelector<CreateTransactionCubit, CreateTransactionState,
                Decoration?>(
              selector: (state) {
                if (state.tabIndex == 0) {
                  return BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.incomeColor,
                  );
                }

                return BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.expenseColor,
                );
              },
              builder: (context, indicatorDecoration) {
                return CustomTabBar(
                    decoration: indicatorDecoration,
                    onTap: _createTransactionCubit.updateTabIndex,
                    tabController: _transactionTypeTabController,
                    tabs: const [Tab(text: "Income"), Text("Expense")]);
              },
            ),
            Expanded(
              child: TabBarView(
                controller: _transactionTypeTabController,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    decoration: defaultBorder,
                    child: BlocBuilder<CreateTransactionCubit,
                        CreateTransactionState>(
                      builder: (context, state) {
                        final paymentSource = state.transactionSource;
                        final transactionCategory = state.transactionCategory;

                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 100,
                                child: CreateTransactionItem(
                                  label: "Date",
                                  value: state.transactionDate.dateFormat(),
                                  onTap: onTransactionDateChanged,
                                ),
                              ),
                              const Divider(
                                  height: 20,
                                  color: Colors.grey,
                                  thickness: 0.2),
                              BlocSelector<CreateTransactionCubit,
                                  CreateTransactionState, Color?>(
                                selector: (state) {
                                  if (state.tabIndex == 0) {
                                    return AppColors.incomeColor;
                                  }

                                  return AppColors.expenseColor;
                                },
                                builder: (context, textColor) {
                                  return SizedBox(
                                    height: 100,
                                    child: CreateTransactionItem(
                                        mediumStyle:
                                            TextStyle(color: textColor),
                                        label: "Amount",
                                        value: state.amount,
                                        onTap: () =>
                                            _showCustomKeyboard(context)),
                                  );
                                },
                              ),
                              const Divider(
                                  height: 20,
                                  color: Colors.grey,
                                  thickness: 0.2),
                              SizedBox(
                                height: 100,
                                child: CreateTransactionItem(
                                    label: "Category",
                                    onTap: () =>
                                        _showTransactionsCategories(context),
                                    value: "Uncategorized",
                                    child: transactionCategory == null
                                        ? null
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(transactionCategory.name),
                                              const SizedBox(width: 5),
                                              Image.asset(
                                                transactionCategory.icon,
                                                width: 30,
                                              )
                                            ],
                                          )),
                              ),
                              const Divider(
                                  height: 20,
                                  color: Colors.grey,
                                  thickness: 0.2),
                              SizedBox(
                                height: 100,
                                child: CreateTransactionItem(
                                    label: "Deposit Source",
                                    onTap: () =>
                                        _showTransactionSources(context),
                                    value: "Uncategorized",
                                    child: paymentSource == null
                                        ? null
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(paymentSource.name),
                                              const SizedBox(width: 5),
                                              Image.asset(
                                                paymentSource.icon,
                                                width: 30,
                                              ),
                                            ],
                                          )),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    decoration: defaultBorder,
                    child: BlocBuilder<CreateTransactionCubit,
                        CreateTransactionState>(
                      builder: (context, state) {
                        final paymentSource = state.transactionSource;
                        final transactionCategory = state.transactionCategory;

                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 100,
                                child: CreateTransactionItem(
                                  label: "Date",
                                  value: state.transactionDate.dateFormat(),
                                  onTap: onTransactionDateChanged,
                                ),
                              ),
                              const Divider(
                                  height: 20,
                                  color: Colors.grey,
                                  thickness: 0.2),
                              SizedBox(
                                height: 100,
                                child: CreateTransactionItem(
                                    mediumStyle: TextStyle(
                                        color: AppColors.expenseColor),
                                    label: "Amount",
                                    value: state.amount,
                                    onTap: () => _showCustomKeyboard(context)),
                              ),
                              const Divider(
                                  height: 20,
                                  color: Colors.grey,
                                  thickness: 0.2),
                              SizedBox(
                                height: 100,
                                child: CreateTransactionItem(
                                    label: "Category",
                                    onTap: () =>
                                        _showTransactionsCategories(context),
                                    value: "Uncategorized",
                                    child: transactionCategory == null
                                        ? null
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(transactionCategory.name),
                                              const SizedBox(width: 5),
                                              Image.asset(
                                                transactionCategory.icon,
                                                width: 30,
                                              )
                                            ],
                                          )),
                              ),
                              const Divider(
                                  height: 20,
                                  color: Colors.grey,
                                  thickness: 0.2),
                              SizedBox(
                                height: 100,
                                child: CreateTransactionItem(
                                    label: "Payment Source",
                                    onTap: () =>
                                        _showTransactionSources(context),
                                    value: "Uncategorized",
                                    child: paymentSource == null
                                        ? null
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(paymentSource.name),
                                              const SizedBox(width: 5),
                                              Image.asset(
                                                paymentSource.icon,
                                                width: 30,
                                              ),
                                            ],
                                          )),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
