import 'package:dartz/dartz.dart';
import 'package:flutter_money_manager/src/core/error/failure/failure.dart';
import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/financial_summary.dart';
import 'package:flutter_money_manager/src/features/accounts/domain/entities/account_summary_item.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transactions_summary.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';

abstract interface class TransactionRepository {
  Future<Either<Failure, bool>> save(Transaction transaction);

  Future<Either<Failure, TransactionsSummary>> getTransactionsByMonth(
      {int? month, int? year});

  Future<Either<Failure, TransactionsSummary>> getTransactionsByDate(
      {required DateTime date});

  Future<Either<Failure, List<AccountSummaryItem>>> getTransactionSources();

  Future<FinancialSummary> getGlobalFinancialSummary();

  Stream<TransactionsSummary> transactionsStream();
}
