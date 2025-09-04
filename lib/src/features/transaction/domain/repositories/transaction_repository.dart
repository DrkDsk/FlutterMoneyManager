import 'package:dartz/dartz.dart';
import 'package:flutter_money_manager/src/core/error/failure/failure.dart';
import 'package:flutter_money_manager/src/features/accounts/domain/entities/account_balance.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_balance.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';

abstract interface class TransactionRepository {
  Future<Either<Failure, bool>> saveTransaction(Transaction transaction);
  Future<Either<Failure, TransactionBalance>> getTransactionsByMonth(
      {int? monthIndex});
  Future<Either<Failure, TransactionBalance>> getTransactionsByDate(
      {required DateTime date});

  Future<Either<Failure, List<AccountBalance>>> getTransactionSources();
}
