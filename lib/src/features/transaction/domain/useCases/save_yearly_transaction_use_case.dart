import 'package:dartz/dartz.dart';
import 'package:flutter_money_manager/src/core/error/failure/failure.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/repositories/transaction_repository.dart';

class SaveYearlyTransactionUseCase {
  final TransactionRepository _transactionRepository;

  const SaveYearlyTransactionUseCase(
      {required TransactionRepository transactionRepository})
      : _transactionRepository = transactionRepository;

  Future<Either<Failure, bool>> call({required Transaction transaction}) async {
    final saveTransaction = await _transactionRepository.save(transaction);

    return saveTransaction;
  }
}
