import 'package:bloc/bloc.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0);


  void setPageIndex(int value) {
    emit(value);
  }

  void setTabIndex(int value) {
    emit(value);
  }
}
