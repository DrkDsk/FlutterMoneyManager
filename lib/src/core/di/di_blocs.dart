import 'package:flutter_money_manager/src/features/accounts/ui/blocs/account_bloc.dart';
import 'package:flutter_money_manager/src/features/financial_summary/domain/repositories/financial_summary_repository.dart';
import 'package:flutter_money_manager/src/features/home/ui/blocs/home_redirection_cubit.dart';
import 'package:flutter_money_manager/src/features/home/ui/blocs/navigation_cubit.dart';
import 'package:flutter_money_manager/src/features/stats/domain/repositories/stats_repository.dart';
import 'package:flutter_money_manager/src/features/stats/ui/blocs/stats_bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/useCases/save_yearly_transaction_use_case.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/create/cubit/create_transaction_cubit.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/calendar/calendar_bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/summary/summary_bloc.dart';
import 'package:flutter_money_manager/src/features/transaction/ui/fetch/blocs/transactions/transactions_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> registerBlocs() async {
  final transactionRepositoryInst = getIt<TransactionRepository>();
  final financialSummaryRepositoryInst = getIt<FinancialSummaryRepository>();

  final saveYearlyTransactionUseCaseInst =
      getIt<SaveYearlyTransactionUseCase>();

  getIt.registerFactory<NavigationCubit>(() => NavigationCubit());
  getIt.registerFactory<HomeRedirectionCubit>(() => HomeRedirectionCubit());

  getIt.registerFactory<CreateTransactionCubit>(() => CreateTransactionCubit(
      saveYearlyTransactionUseCase: saveYearlyTransactionUseCaseInst));

  getIt.registerFactory<TransactionsBloc>(
      () => TransactionsBloc(repository: transactionRepositoryInst));

  getIt.registerFactory<CalendarBloc>(
      () => CalendarBloc(repository: transactionRepositoryInst));

  getIt.registerFactory<AccountBloc>(() => AccountBloc(
      transactionRepository: transactionRepositoryInst,
      financialSummaryRepository: financialSummaryRepositoryInst));

  getIt.registerFactory<StatsBloc>(
      () => StatsBloc(repository: getIt<StatsRepository>()));

  getIt.registerFactory<SummaryBloc>(() => SummaryBloc());
}
