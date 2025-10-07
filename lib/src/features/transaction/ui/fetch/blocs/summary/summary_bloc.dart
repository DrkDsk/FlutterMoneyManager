import 'package:bloc/bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/summary/summary_event.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/summary/summary_state.dart';

class SummaryBloc extends Bloc<SummaryEvent, SummaryState> {
  SummaryBloc() : super(SummaryState.initial()) {
    on<FetchSummaryEvent>(_fetchSummaryEvent);
  }

  Future<void> _fetchSummaryEvent(
      FetchSummaryEvent event, Emitter<SummaryState> emit) async {
    final currentMonthIndex = event.currentMonthIndex;
    print("currentMonthIndex: $currentMonthIndex");
  }
}
