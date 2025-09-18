import 'package:bloc/bloc.dart';
import 'package:flutter_money_manager/src/features/stats/domain/repositories/stats_repository.dart';
import 'package:flutter_money_manager/src/features/stats/ui/blocs/stats_event.dart';
import 'package:flutter_money_manager/src/features/stats/ui/blocs/stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  final StatsRepository _repository;

  StatsBloc({required StatsRepository repository})
      : _repository = repository,
        super(StatsState.initial()) {
    on<LoadStatsEvent>(_loadStats);
  }

  Future<void> _loadStats(
      LoadStatsEvent event, Emitter<StatsState> emit) async {
    final monthlyTransactionsRequest = await _repository.getStatMonth();

    monthlyTransactionsRequest.fold((left) {}, (right) {
      emit(state.copyWith(data: right));
    });
  }
}
