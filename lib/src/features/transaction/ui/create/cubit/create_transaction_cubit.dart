import 'package:bloc/bloc.dart';

import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_source.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_category.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/usecases/save_financial_summary_use_case.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/usecases/save_year_financial_summary_use_case.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/usecases/save_yearly_transaction_use_case.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/create/cubit/create_transaction_state.dart';

class CreateTransactionCubit extends Cubit<CreateTransactionState> {
  final SaveYearlyTransactionUseCase saveYearlyTransactionUseCase;
  final SaveYearFinancialSummaryUseCase saveYearFinancialSummaryUseCase;
  final SaveFinancialSummaryUseCase saveFinancialSummaryUseCase;

  CreateTransactionCubit(
      {required this.saveYearlyTransactionUseCase,
      required this.saveYearFinancialSummaryUseCase,
      required this.saveFinancialSummaryUseCase})
      : super(CreateTransactionState.initial());

  void loadTransactionToEdit({required Transaction? transaction}) {
    final newState = state.copyWith(transaction: transaction);

    emit(_validForm(newState));
  }

  void updateAmountDate(DateTime? time) {
    final transaction = state.transaction.copyWith(transactionDate: time);
    final newState = state.copyWith(transaction: transaction);

    emit(_validForm(newState));
  }

  void updateAmount(int? amount) {
    final transaction = state.transaction.copyWith(amount: amount);
    final newState =
        state.copyWith(transaction: transaction.copyWith(amount: amount));

    emit(_validForm(newState));
  }

  void updateTransactionSource(TransactionSource source) {
    final transaction = state.transaction;
    final newState = state.copyWith(
        transaction: transaction.copyWith(sourceType: source.name));

    emit(_validForm(newState));
  }

  void updateTransactionCategory(TransactionCategory category) {
    final transaction = state.transaction;

    final newState = state.copyWith(
        transaction: transaction.copyWith(categoryType: category.name));

    emit(_validForm(newState));
  }

  CreateTransactionState _validForm(CreateTransactionState newState) {
    final transaction = newState.transaction;

    final amount = transaction.amount;
    final transactionSource = transaction.sourceType;
    final transactionCategory = transaction.categoryType;

    final bool formIsValidated = (transactionSource == null ||
            transactionCategory == null ||
            amount == 0)
        ? false
        : true;

    return newState.copyWith(formIsValidated: formIsValidated);
  }

  void updateTransactionType(int index) {
    final transaction = state.transaction;

    final transactionType =
        index == 0 ? TransactionTypEnum.income : TransactionTypEnum.expense;
    final updatedTransaction = transaction.copyWith(
        type: transactionType, categoryType: "", sourceType: "");

    emit(state.copyWith(transaction: updatedTransaction));
  }

  Future<void> saveTransaction() async {
    final transaction = state.transaction;

    emit(state.copyWith(status: CreateTransactionStatus.loading));

    try {
      await Future.wait([
        saveYearlyTransactionUseCase(transaction: transaction),
        saveYearFinancialSummaryUseCase(transaction: transaction),
        saveFinancialSummaryUseCase(transaction: transaction)
      ]);
      emit(state.copyWith(status: CreateTransactionStatus.success));
    } catch (e) {
      emit(state.copyWith(status: CreateTransactionStatus.error));
    }
  }
}
