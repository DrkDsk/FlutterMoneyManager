import 'package:dartz/dartz.dart';
import 'package:flutter_money_manager/src/core/error/failure/failure.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/repositories/transaction_repository.dart';

class SaveYearlyTransactionUseCase {
  final TransactionRepository _repository;

  const SaveYearlyTransactionUseCase(
      {required TransactionRepository repository})
      : _repository = repository;

  Future<Either<Failure, bool>> call({required Transaction transaction}) async {
    return _repository.save(transaction);
  }
}
