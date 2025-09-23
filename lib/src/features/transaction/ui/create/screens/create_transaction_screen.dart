import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_money_manager/src/core/colors/app_colors.dart';
import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/core/extensions/string_extension.dart';
import 'package:flutter_money_manager/src/core/router/app_router.dart';
import 'package:flutter_money_manager/src/core/shared/builders/keyboard/keyboard_helper.dart';
import 'package:flutter_money_manager/src/core/shared/widgets/bloc_side_effect_listener.dart';
import 'package:flutter_money_manager/src/core/shared/widgets/custom_app_bar.dart';
import 'package:flutter_money_manager/src/core/styles/container_styles.dart';
import 'package:flutter_money_manager/src/features/stats/ui/widgets/custom_tab_bar.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_category.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/create/cubit/create_transaction_cubit.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/create/cubit/create_transaction_state.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/create/widgets/bottom_transaction_sources.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/create/widgets/bottom_transaction_category.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/create/widgets/create_transaction_bottom_appbar.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/create/widgets/create_transaction_tabview.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/transactions/transactions_bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/transactions/transactions_event.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/transactions/transactions_state.dart';

class CreateTransactionScreen extends StatefulWidget {
  const CreateTransactionScreen({super.key, this.transaction});

  final Transaction? transaction;

  @override
  State<CreateTransactionScreen> createState() =>
      _CreateTransactionScreenState();
}

class _CreateTransactionScreenState extends State<CreateTransactionScreen>
    with TickerProviderStateMixin {
  late final CreateTransactionCubit _createTransactionCubit;
  late final TransactionsBloc _transactionsBloc;
  late AppRouter _router;
  late TabController _transactionTypeTabController;

  StringBuffer amountValue = StringBuffer();

  @override
  void initState() {
    super.initState();
    final transaction = widget.transaction;
    _createTransactionCubit = BlocProvider.of<CreateTransactionCubit>(context);
    _transactionsBloc = BlocProvider.of<TransactionsBloc>(context);
    _createTransactionCubit.loadTransactionToEdit(transaction: transaction);

    int initialTabIndex = transaction == null
        ? 0
        : ((transaction.type == TransactionTypEnum.income) ? 0 : 1);

    _router = AppRouter.of(context);
    _transactionTypeTabController = TabController(
      initialIndex: initialTabIndex,
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _transactionTypeTabController.dispose();
  }

  void _showTransactionSources(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(),
      builder: (context) {
        return BottomTransactionSources(
          onSelectTransactionSource: (transactionSource) {
            _createTransactionCubit.updateTransactionSource(transactionSource);
            _router.pop();
          },
        );
      },
    );
  }

  void _showTransactionsCategories(BuildContext context,
      {required List<TransactionCategory> items}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(),
      builder: (context) {
        return BottomTransactionCategory(
          items: items,
          onSelectCategory: (category) {
            _createTransactionCubit.updateTransactionCategory(category);
            _router.pop();
          },
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
    _createTransactionCubit.saveTransaction();
    _router.pop();
  }

  void _handleDeleteTransaction() async {
    final transactionId = widget.transaction?.id;

    if (transactionId == null) {
      return;
    }

    _transactionsBloc.add(DeleteTransaction(id: transactionId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocSideEffectListener<TransactionsBloc, SideEffect>(
      bloc: BlocProvider.of<TransactionsBloc>(context),
      listener: (context, effect) {
        switch (effect) {
          case TransactionBlockedLoadingEffect():
            break;
          case TransactionNavigationSideEffect():
            _router.pop();
            break;
          case TransactionShowErrorSideEffect():
            break;
        }
      },
      child: Scaffold(
        appBar: const CustomAppBar(),
        bottomNavigationBar: CreateTransactionBottomAppBar(
          onTapSaveButton: _handleSaveTransaction,
          onTapDeleteButton:
              widget.transaction?.id != null ? _handleDeleteTransaction : null,
        ),
        body: SafeArea(
          child: Column(
            children: [
              BlocSelector<CreateTransactionCubit, CreateTransactionState,
                  Decoration?>(
                selector: (state) {
                  final isIncomeTransaction =
                      state.transaction.type == TransactionTypEnum.income;

                  return isIncomeTransaction
                      ? ContainerStyles.incomeDecoration
                      : ContainerStyles.expenseDecoration;
                },
                builder: (context, indicatorDecoration) {
                  return CustomTabBar(
                      decoration: indicatorDecoration,
                      onTap: _createTransactionCubit.updateTransactionType,
                      tabController: _transactionTypeTabController,
                      tabs: [
                        Tab(
                            text:
                                TransactionsConstants.kIncomeType.firstUpper()),
                        Tab(
                            text:
                                TransactionsConstants.kExpenseType.firstUpper())
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
                      onTapAmount: () => KeyboardHelper.showCustomKeyboard(
                          context: context,
                          onAmountChanged: (value) =>
                              _createTransactionCubit.updateAmount(value),
                          onOkSubmit: () => _router.pop(),
                          currentAmount: _createTransactionCubit
                              .state.transaction.amount
                              .toString(),
                          amountValue: amountValue),
                      onTapCategory: () => _showTransactionsCategories(context,
                          items:
                              TransactionsConstants.kDefaultIncomeCategories),
                      onTapTransactionSource: () =>
                          _showTransactionSources(context),
                    ),
                    CreateTransactionTabview(
                      transactionTypeSource: "Payment Source",
                      amountLabelColor: AppColors.expenseColor,
                      onSelectTransactionDate: onTransactionDateChanged,
                      onTapAmount: () => KeyboardHelper.showCustomKeyboard(
                          context: context,
                          onAmountChanged: (value) =>
                              _createTransactionCubit.updateAmount(value),
                          onOkSubmit: () => _router.pop(),
                          currentAmount: _createTransactionCubit
                              .state.transaction.amount
                              .toString(),
                          amountValue: amountValue),
                      onTapCategory: () => _showTransactionsCategories(context,
                          items:
                              TransactionsConstants.kDefaultExpenseCategories),
                      onTapTransactionSource: () =>
                          _showTransactionSources(context),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
