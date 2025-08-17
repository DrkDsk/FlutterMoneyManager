import 'package:bloc/bloc.dart';
import 'package:flutter_money_manager/src/features/home/ui/blocs/home_redirection_state.dart';

class HomeRedirectionCubit extends Cubit<HomeRedirectionState> {
  HomeRedirectionCubit() : super(const HomeRedirectionState());


  void checkRedirectionStatus() async {
    emit(state.copyWith(status: RedirectionStatus.loading));

    await Future.delayed(const Duration(seconds: 2));

    emit(state.copyWith(status: RedirectionStatus.login));
  }
}
