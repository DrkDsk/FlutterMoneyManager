import 'package:bloc/bloc.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';
import 'package:flutter_money_manager/src/features/stats/domain/repositories/stats_repository.dart';
import 'package:flutter_money_manager/src/features/stats/ui/blocs/stats_event.dart';
import 'package:flutter_money_manager/src/features/stats/ui/blocs/stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final StatsRepository _repository;

  StatsBloc({required StatsRepository repository})
      : _repository = repository,
        super(StatsState.initial()) {
    on<LoadStatsEvent>(_loadStats);
    on<UpdateTransactionType>(_updateTransactionType);
  }

  Future<void> _loadStats(
      LoadStatsEvent event, Emitter<StatsState> emit) async {
    final type = event.type;
    final month = event.month;
    final year = event.year;

    final monthlyTransactionsRequest =
        await _repository.getStatMonth(type: type, month: month, year: year);

    monthlyTransactionsRequest.fold((left) {}, (right) {
      emit(state.copyWith(data: right));
    });
  }

  Future<void> _updateTransactionType(
      UpdateTransactionType event, Emitter<StatsState> emit) async {
    final tabIndex = event.tabIndex;

    final type =
        tabIndex == 0 ? TransactionTypEnum.income : TransactionTypEnum.expense;

    emit(state.copyWith(type: type));
  }
}
