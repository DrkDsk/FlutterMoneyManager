import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_money_manager/src/core/error/exceptions/unknown_exception.dart';
import 'package:flutter_money_manager/src/core/error/failure/failure.dart';
import 'package:flutter_money_manager/src/features/accounts/domain/entities/account_summary_item.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_model.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transactions_summary.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/services/transaction_service.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionService _transactionService;
  final _transactionsController =
      StreamController<TransactionsSummary>.broadcast();

  TransactionRepositoryImpl({required TransactionService transactionService})
      : _transactionService = transactionService;

  @override
  Future<Either<Failure, bool>> save(Transaction transaction) async {
    try {
      await _transactionService.saveTransaction(
          transactionModel: TransactionModel.fromEntity(transaction));

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

      final transactions = await _transactionService.getTransactionsMonth(
          year: year, month: month);

      final monthSummary = await _transactionService.getSummaryWithTransactions(
          transactions: transactions);

      return Right(monthSummary);
    } on UnknownException catch (_) {
      return Left(GenericFailure());
    } catch (e) {
      return Left(GenericFailure());
    }
  }

  @override
  Future<Either<Failure, TransactionsSummary>> getTransactionSummaryByDate(
      {required DateTime date}) async {
    final transactions =
        await _transactionService.getTransactionsByDate(date: date);

    final summary = await _transactionService.getSummaryWithTransactions(
        transactions: transactions);

    _transactionsController.add(summary);

    return Right(summary);
  }

  @override
  Future<Either<Failure, List<AccountSummaryItem>>>
      getTransactionSources() async {
    final accountSummaryItems =
        await _transactionService.getAccountSummaryItems();

    return Right(accountSummaryItems);
  }
}
