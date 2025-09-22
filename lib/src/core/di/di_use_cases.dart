import 'package:flutter_money_manager/src/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/useCases/save_yearly_transaction_use_case.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> registerUseCases() async {
  final transactionRepositoryInst = getIt<TransactionRepository>();

  getIt.registerLazySingleton<SaveYearlyTransactionUseCase>(() =>
      SaveYearlyTransactionUseCase(
          transactionRepository: transactionRepositoryInst));
}
