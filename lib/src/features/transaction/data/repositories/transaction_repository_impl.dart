import 'dart:isolate';

import 'package:dartz/dartz.dart';
import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';

import 'package:flutter_money_manager/src/core/error/exceptions/unknown_exception.dart';
import 'package:flutter_money_manager/src/core/error/failure/failure.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_balance.dart';
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
  Future<Either<Failure, TransactionBalance>> getTransactionsByMonth(
      {int? monthIndex}) async {
    try {
      final models = await _datasource.getTransactionsModels(
          monthIndex: monthIndex ?? DateTime.now().month);

      final rawModels = models.map((element) => element.toJson()).toList();

      final balance = await Isolate.run(() {
        int income = 0;
        int expense = 0;

        final grouped = <DateTime, List<Map<String, dynamic>>>{};

        for (final raw in rawModels) {
          final date =
              DateTime.fromMillisecondsSinceEpoch(raw['transactionDate']);
          grouped.putIfAbsent(date, () => []).add(raw);
        }

        final transactionsData = grouped.entries.map((entry) {
          final transactions = entry.value.map((raw) {
            final id = raw["id"] as String;
            final amount = (raw["amount"] as num).toInt();

            final transactionType = raw['type'] as String;
            final categoryType = raw["categoryType"] as String;
            final sourceType = raw["categoryType"] as String;
            final transactionDate = DateTime.fromMillisecondsSinceEpoch(
                raw['transactionDate'] as int);

            return Transaction(
                id: id,
                type: transactionType,
                amount: amount,
                transactionDate: transactionDate,
                categoryType: categoryType,
                sourceType: sourceType);
          }).toList();

          for (final transaction in transactions) {
            if (transaction.type == kIncomeType) {
              income += transaction.amount;
            } else {
              expense += transaction.amount;
            }
          }

          return TransactionsData(
            transactions: transactions,
            date: entry.key,
          );
        }).toList();

        return TransactionBalance(
            transactionsData: transactionsData,
            income: income,
            expense: expense,
            total: income - expense);
      });

      return Right(balance);
    } on UnknownException catch (_) {
      return Left(GenericFailure());
    } catch (e) {
      return Left(GenericFailure());
    }
  }
}
