import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_money_manager/src/core/colors/app_colors.dart';
import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/core/extensions/color_extension.dart';
import 'package:flutter_money_manager/src/core/router/app_router.dart';
import 'package:flutter_money_manager/src/core/shared/widgets/custom_app_bar.dart';
import 'package:flutter_money_manager/src/core/shared/widgets/custom_numeric_keyboard.dart';
import 'package:flutter_money_manager/src/features/stats/ui/widgets/custom_tab_bar.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_category.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/create/cubit/create_transaction_cubit.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/create/cubit/create_transaction_state.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/create/widgets/bottom_transaction_sources.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/create/widgets/bottom_transaction_category.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/create/widgets/create_transaction_bottom_appbar.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/create/widgets/create_transaction_tabview.dart';

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

                final updatedAmount = int.tryParse(amountValue.toString()) ?? 0;

                _createTransactionCubit.updateAmount(updatedAmount);
              },
              onBackspace: () {
                final amountString =
                    _createTransactionCubit.state.transaction.amount.toString();

                if (amountString.length <= 1) {
                  _createTransactionCubit.updateAmount(0);
                  amountValue.clear();
                  return;
                }

                final updatedString =
                    amountString.substring(0, amountString.length - 1);
                final updatedAmount = int.tryParse(updatedString) ?? 0;

                amountValue
                  ..clear()
                  ..write(updatedString);

                _createTransactionCubit.updateAmount(updatedAmount);
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

  _showTransactionsCategories(BuildContext context,
      {required List<TransactionCategory> items}) {
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
                items: items,
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

  void _handleSaveTransaction() async {
    await _createTransactionCubit.saveTransaction();
    _router.pop();
  }

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
                if (state.transaction.type == TransactionTypeEnum.income) {
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
                    onTap: _createTransactionCubit.updateTransactionType,
                    tabController: _transactionTypeTabController,
                    tabs: [
                      ...kDefaultTransactionTypes.map((transactionType) {
                        return Tab(text: transactionType.name);
                      })
                    ]);
              },
            ),
            Expanded(
              child: TabBarView(
                controller: _transactionTypeTabController,
                children: [
                  CreateTransactionTabview(
                    amountLabelColor: AppColors.incomeColor,
                    transactionTypeSource: "Deposit Source",
                    onSelectTransactionDate: onTransactionDateChanged,
                    onTapAmount: () => _showCustomKeyboard(context),
                    onTapCategory: () => _showTransactionsCategories(context,
                        items: kDefaultIncomeCategories),
                    onTapTransactionSource: () =>
                        _showTransactionSources(context),
                  ),
                  CreateTransactionTabview(
                    transactionTypeSource: "Payment Source",
                    amountLabelColor: AppColors.expenseColor,
                    onSelectTransactionDate: onTransactionDateChanged,
                    onTapAmount: () => _showCustomKeyboard(context),
                    onTapCategory: () => _showTransactionsCategories(context,
                        items: kDefaultExpenseCategories),
                    onTapTransactionSource: () =>
                        _showTransactionSources(context),
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
