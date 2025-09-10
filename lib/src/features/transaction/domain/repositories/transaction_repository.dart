import 'package:dartz/dartz.dart';
import 'package:flutter_money_manager/src/core/error/failure/failure.dart';
import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/financial_summary.dart';
import 'package:flutter_money_manager/src/features/accounts/domain/entities/account_balance.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transactions_summary.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';

abstract interface class TransactionRepository {
  Future<Either<Failure, bool>> saveTransaction(Transaction transaction);

  Future<Either<Failure, TransactionsSummary>> getTransactionsByMonth(
      {int? month, int? year});

  Future<Either<Failure, TransactionsSummary>> getTransactionsByDate(
      {required DateTime date});

  Future<Either<Failure, List<AccountBalance>>> getTransactionSources();

  Future<FinancialSummary?> getGlobalTransactionsBalance();

  Stream<TransactionsSummary> transactionsStream();

  Future<Either<Failure, Map<int, FinancialSummary>?>> getBalanceByYear(
      {int? year});
}
