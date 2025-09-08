import 'package:bloc/bloc.dart';
import 'package:flutter_money_manager/src/features/stats/ui/blocs/stats_event.dart';
import 'package:flutter_money_manager/src/features/stats/ui/blocs/stats_state.dart';

class StatsBloc extends Bloc<StatsEvent, StatsState> {
  StatsBloc() : super(StatsState()) {
    on<StatsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
