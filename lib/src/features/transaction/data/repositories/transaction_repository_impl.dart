import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_money_manager/src/core/error/exceptions/unknown_exception.dart';
import 'package:flutter_money_manager/src/core/error/failure/failure.dart';
import 'package:flutter_money_manager/src/core/helpers/hive_helper.dart';
import 'package:flutter_money_manager/src/features/accounts/domain/entities/account_summary_item.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transactions_summary.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/services/transaction_service.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionDatasource _transactionDatasource;
  final TransactionService _transactionService;
  final _transactionsController =
      StreamController<TransactionsSummary>.broadcast();

  TransactionRepositoryImpl(
      {required TransactionDatasource transactionDatasource,
      required TransactionService transactionService})
      : _transactionDatasource = transactionDatasource,
        _transactionService = transactionService;

  @override
  Future<Either<Failure, bool>> save(Transaction transaction) async {
    try {
      await _transactionService.saveYearlyTransaction(transaction: transaction);

      return const Right(true);
    } on UnknownException catch (_) {
      return Left(GenericFailure());
    } catch (e) {
      return Left(GenericFailure());
    }
  }

  @override
  Stream<TransactionsSummary> transactionsStream() {
    return _transactionsController.stream;
  }

  @override
  Future<Either<Failure, TransactionsSummary>> getTransactionsByMonth(
      {int? month, int? year}) async {
    try {
      final now = DateTime.now();
      year = year ?? now.year;
      month = month ?? now.month;
      final yearlyBalanceKey = HiveHelper.generateYearlyBalanceKey(year: year);

      final monthBalance = await _transactionService.getBalanceByMonth(
          key: yearlyBalanceKey, month: month);

      final monthTransactions = await _transactionService.getTransactionsMonth(
          year: year, month: month);

      final transactionsSummary = await _transactionService.getMonthSummary(
          monthTransactions: monthTransactions, monthBalance: monthBalance);

      return Right(transactionsSummary);
    } on UnknownException catch (_) {
      return Left(GenericFailure());
    } catch (e) {
      return Left(GenericFailure());
    }
  }

  @override
  Future<Either<Failure, TransactionsSummary>> getTransactionsByDate(
      {required DateTime date}) async {
    final yearlyKey = HiveHelper.generateYearlyTransactionKey(year: date.year);

    final yearlyModel =
        await _transactionDatasource.getYearlyTransactions(key: yearlyKey);

    final yearlySummary = await _transactionService.getYearlySummary(
        yearlyModel: yearlyModel, date: date);

    _transactionsController.add(yearlySummary);

    return Right(yearlySummary);
  }

  @override
  Future<Either<Failure, List<AccountSummaryItem>>>
      getTransactionSources() async {
    final transactionsSourceModels =
        await _transactionDatasource.getTransactionSources();

    final accountSummaryItems =
        await _transactionService.getAccountSummaryItems(
            transactionsSourceModels: transactionsSourceModels);

    return Right(accountSummaryItems);
  }
}
