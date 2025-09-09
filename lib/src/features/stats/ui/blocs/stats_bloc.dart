import 'package:bloc/bloc.dart';
import 'package:flutter_money_manager/src/features/stats/ui/blocs/stats_event.dart';
import 'package:flutter_money_manager/src/features/stats/ui/blocs/stats_state.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/repositories/transaction_repository.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final TransactionRepository _transactionRepository;

  StatsBloc({required TransactionRepository repository})
      : _transactionRepository = repository,
        super(StatsState()) {
    on<LoadStatsEvent>(_loadStats);
  }

  Future<void> _loadStats(
      LoadStatsEvent event, Emitter<StatsState> emit) async {
    final request = await _transactionRepository.getGlobalTransactionsBalance();
  }
}
