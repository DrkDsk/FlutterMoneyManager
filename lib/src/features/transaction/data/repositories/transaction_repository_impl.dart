import 'package:dartz/dartz.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';

import 'package:flutter_money_manager/src/core/error/exceptions/unknown_exception.dart';
import 'package:flutter_money_manager/src/core/error/failure/failure.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transactions_data.dart';
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
  Future<Either<Failure, List<TransactionsData>>> getTransactions(
      {int? monthIndex}) async {
    try {
      final Map<DateTime, List<TransactionHiveModel>> grouped = {};

      final models = await _datasource.getTransactionsModels(
          monthIndex: monthIndex ?? DateTime.now().month);

      for (final tx in models) {
        final dateOnly = DateTime(tx.transactionDate.year,
            tx.transactionDate.month, tx.transactionDate.day);
        grouped.putIfAbsent(dateOnly, () => []).add(tx);
      }

      final result = grouped.entries.map((entry) {
        final transactions = entry.value.map((e) => e.toEntity()).toList();

        final income = transactions
            .where((t) => t.type == TransactionTypeEnum.income)
            .fold<int>(0, (sum, t) => sum + t.amount);
        final expense = transactions
            .where((t) => t.type == TransactionTypeEnum.expense)
            .fold<int>(0, (sum, t) => sum + t.amount);

        return TransactionsData(
          transactions: transactions,
          date: entry.key,
          incomeBalance: income,
          expenseBalance: expense,
        );
      }).toList();

      return Right(result);
    } on UnknownException catch (_) {
      return Left(GenericFailure());
    } catch (e) {
      return Left(GenericFailure());
    }
  }
}
