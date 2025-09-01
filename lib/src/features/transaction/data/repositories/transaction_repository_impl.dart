import 'package:dartz/dartz.dart';

import 'package:flutter_money_manager/src/core/error/exceptions/unknown_exception.dart';
import 'package:flutter_money_manager/src/core/error/failure/failure.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionDatasource _datasource;

  const TransactionRepositoryImpl({required TransactionDatasource datasource})
      : _datasource = datasource;

  @override
  Future<Either<Failure, bool>> saveTransaction(Transaction transaction) async {
    try {
      final result = await _datasource.saveTransaction(transaction);

      return Right(result);
    } on UnknownException catch (_) {
      return Left(GenericFailure());
    } catch (e) {
      return Left(GenericFailure());
    }
  }

  @override
  Future<Either<Failure, List<Transaction>>> getTransactions(
      {int? monthIndex}) async {
    try {
      final models = await _datasource.getTransactionsModels(
          monthIndex: monthIndex ?? DateTime.now().month);

      final entities = models
          .map((transactionHiveModel) => transactionHiveModel.toEntity())
          .toList();

      return Right(entities);
    } on UnknownException catch (_) {
      return Left(GenericFailure());
    } catch (e) {
      return Left(GenericFailure());
    }
  }
}
