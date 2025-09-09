import 'package:bloc/bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/repositories/transaction_repository.dart';
import './account_state.dart';
import './account_event.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final TransactionRepository _transactionRepository;

  AccountBloc({required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository,
        super(AccountState.initial()) {
    on<LoadTransactionsSource>(_loadTransactionsSource);
    on<GetGlobalBalance>(_getGlobalBalance);
  }

  Future<void> _loadTransactionsSource(
      LoadTransactionsSource event, Emitter<AccountState> emit) async {
    final result = await _transactionRepository.getTransactionSources();

    result.fold((left) {}, (right) {
      final accountBalances = right;

      emit(state.copyWith(accountBalances: accountBalances));
    });
  }

  Future<void> _getGlobalBalance(
      GetGlobalBalance event, Emitter<AccountState> emit) async {
    final result = await _transactionRepository.getTransactionsByYear();

    result.fold((left) {}, (right) {});
    /*emit(state.copyWith(globalBalance: result));*/
  }
}
