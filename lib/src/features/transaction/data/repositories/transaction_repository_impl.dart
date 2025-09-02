import 'dart:isolate';

import 'package:dartz/dartz.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';

import 'package:flutter_money_manager/src/core/error/exceptions/unknown_exception.dart';
import 'package:flutter_money_manager/src/core/error/failure/failure.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_category.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_source.dart';
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
      final models = await _datasource.getTransactionsModels(
          monthIndex: monthIndex ?? DateTime.now().month);

      final rawModels = models.map((element) => element.toJson()).toList();

      final result = await Isolate.run(() {
        final grouped = <DateTime, List<Map<String, dynamic>>>{};

        for (final raw in rawModels) {
          final date =
              DateTime.fromMillisecondsSinceEpoch(raw['transactionDate']);
          grouped.putIfAbsent(date, () => []).add(raw);
        }

        final result = grouped.entries.map((entry) {
          final transactions = entry.value.map((raw) {
            final value = raw["amount"] as num;
            final amount = value.toInt();
            final type = raw['type'] == "expense"
                ? TransactionTypeEnum.expense
                : TransactionTypeEnum.income;

            final categoryType =
                TransactionCategory.fromString(raw["categoryType"])
                    .getCategoryType();
            final sourceType =
                TransactionSource.fromString(raw['sourceType']).getType();

            final transactionDate = DateTime.fromMillisecondsSinceEpoch(
                raw['transactionDate'] as int);

            final id = raw["id"] as String;

            return Transaction(
                type: type,
                amount: amount,
                transactionDate: transactionDate,
                categoryType: raw["categoryType"] as String,
                sourceType: raw["categoryType"] as String,
                id: id);
          }).toList();

          int income = 0;
          int expense = 0;
          for (final t in transactions) {
            if (t.type == TransactionTypeEnum.income) {
              income += t.amount;
            } else {
              expense += t.amount;
            }
          }

          return TransactionsData(
            transactions: transactions,
            date: entry.key,
            incomeBalance: income,
            expenseBalance: expense,
          );
        }).toList();

        return result;
      });

      return Right(result);
    } on UnknownException catch (_) {
      return Left(GenericFailure());
    } catch (e) {
      return Left(GenericFailure());
    }
  }
}
