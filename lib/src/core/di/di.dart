import 'package:flutter_money_manager/src/features/ui/blocs/navigation_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  getIt.registerFactory<NavigationCubit>(() => NavigationCubit());
}