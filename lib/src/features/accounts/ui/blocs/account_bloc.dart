import 'package:bloc/bloc.dart';
import 'package:flutter_money_manager/src/features/financial_summary/domain/repositories/financial_summary_repository.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/repositories/transaction_repository.dart';
import './account_state.dart';
import './account_event.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final TransactionRepository _transactionRepository;
  final FinancialSummaryRepository _financialSummaryRepository;

  AccountBloc(
      {required TransactionRepository transactionRepository,
      required FinancialSummaryRepository financialSummaryRepository})
      : _transactionRepository = transactionRepository,
        _financialSummaryRepository = financialSummaryRepository,
        super(AccountState.initial()) {
    on<LoadTransactionsSource>(_loadTransactionsSource);
    on<GetGlobalBalance>(_getGlobalBalance);
  }

  Future<void> _loadTransactionsSource(
      LoadTransactionsSource event, Emitter<AccountState> emit) async {
    final result = await _transactionRepository.getTransactionSources();

    result.fold((left) {}, (right) {
      final accountBalances = right;

      emit(state.copyWith(accountSummaries: accountBalances));
    });
  }

  Future<void> _getGlobalBalance(
      GetGlobalBalance event, Emitter<AccountState> emit) async {
    final result =
        await _financialSummaryRepository.getGlobalFinancialSummary();

    emit(state.copyWith(financialSummary: result));
  }
}
