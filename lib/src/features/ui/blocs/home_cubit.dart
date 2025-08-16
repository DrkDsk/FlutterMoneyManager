import 'package:bloc/bloc.dart';
import 'package:flutter_money_manager/src/features/ui/blocs/home_state.dart';
import 'package:meta/meta.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState());


  void setPageIndex(int value) {
    emit(state.copyWith(pageIndex: value));
  }

  void setTabIndex(int value) {
    emit(state.copyWith(tabIndex: value));
  }
}
