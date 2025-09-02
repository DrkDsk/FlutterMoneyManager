import 'package:dartz/dartz.dart';
import 'package:flutter_money_manager/src/core/error/failure/failure.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transactions_data.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';

abstract interface class TransactionRepository {
  Future<Either<Failure, bool>> saveTransaction(Transaction transaction);
  Future<Either<Failure, List<TransactionsData>>> getTransactions(
      {int? monthIndex});
}
