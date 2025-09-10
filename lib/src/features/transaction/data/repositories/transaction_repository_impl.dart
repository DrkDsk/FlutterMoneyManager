import 'dart:async';
import 'dart:isolate';

import 'package:dartz/dartz.dart';
import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';

import 'package:flutter_money_manager/src/core/error/exceptions/unknown_exception.dart';
import 'package:flutter_money_manager/src/core/error/failure/failure.dart';
import 'package:flutter_money_manager/src/core/helpers/datetime_helper.dart';
import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/global_balance.dart';
import 'package:flutter_money_manager/src/features/accounts/domain/entities/account_balance.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_balance.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_source.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transactions_data.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionDatasource _datasource;
  final _transactionsController =
      StreamController<TransactionBalance>.broadcast();

  TransactionRepositoryImpl({required TransactionDatasource datasource})
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
  Stream<TransactionBalance> transactionsStream() {
    return _transactionsController.stream;
  }

  @override
  Future<Either<Failure, TransactionBalance>> getTransactionsByMonth(
      {int? month, int? year}) async {
    try {
      final now = DateTime.now();
      final defaultMonth = month ?? now.month;
      final defaultYear = year ?? now.year;

      final transactionsModelsMonth =
          await _datasource.getTransactionsModelsMonth(
        month: defaultMonth,
        year: defaultYear,
      );

      final monthBalance = await _datasource.getBalancesMonth(
        month: defaultMonth,
        year: defaultYear,
      );

      final transactionsBalance = await Isolate.run(() {
        final transactionsData = transactionsModelsMonth.entries.map((entry) {
          final date = DatetimeHelper.parse(input: entry.key);
          final transactions = entry.value.map((t) => t.toEntity()).toList();
          return TransactionsData(transactions: transactions, date: date);
        }).toList();

        final transactionsBalance = TransactionBalance(
          transactionsData: transactionsData,
          income: monthBalance.income,
          total: monthBalance.total,
          expense: monthBalance.expense,
        );

        return transactionsBalance;
      });

      return Right(transactionsBalance);
    } on UnknownException catch (_) {
      return Left(GenericFailure());
    } catch (e) {
      return Left(GenericFailure());
    }
  }

  @override
  Future<Either<Failure, TransactionBalance>> getTransactionsByDate(
      {required DateTime date}) async {
    final models = await _datasource.getTransactionsModelsByDate(date: date);
    final rawModels = models.map((model) => model.toMap()).toList();
    final grouped = {date: rawModels};

    int income = 0;
    int expense = 0;

    final transactionData = await Isolate.run(() {
      final transactionsModelsRaw = (grouped[date] ?? []).toList();

      final transactions = transactionsModelsRaw.map((entry) {
        final transactionModel = TransactionHiveModel.fromMap(entry);
        return transactionModel.toEntity();
      }).toList();

      return TransactionsData(transactions: transactions, date: date);
    });

    for (final transaction in transactionData.transactions) {
      if (transaction.type == TransactionTypEnum.income) {
        income += transaction.amount;
      } else {
        expense += transaction.amount;
      }
    }

    final TransactionBalance transactionBalance = TransactionBalance(
        transactionsData: [transactionData],
        income: income,
        total: income - expense,
        expense: expense);

    _transactionsController.add(transactionBalance);

    return Right(transactionBalance);
  }

  @override
  Future<Either<Failure, List<AccountBalance>>> getTransactionSources() async {
    final transactionsSourceModels = await _datasource.getTransactionSources();

    final modelsRaw =
        transactionsSourceModels.map((model) => model.toJson()).toList();

    final result = await Isolate.run(() {
      final data = modelsRaw.map((source) {
        final name = source["name"] as String;
        final icon = source["icon"] as String;

        final transactionSource = TransactionSource(name: name, icon: icon);
        const amount = 0;

        return AccountBalance(
            transactionSource: transactionSource, amount: amount);
      }).toList();

      return data;
    });

    final defaultTransactionSource = TransactionsConstants
        .kDefaultTransactionSources
        .map((transactionSource) =>
            AccountBalance(transactionSource: transactionSource, amount: 0))
        .toList();

    result.addAll(defaultTransactionSource);

    return Right(result);
  }

  @override
  Future<GlobalBalance?> getGlobalTransactionsBalance() async {
    final globalTransactionBalanceModel = await _datasource.getGlobalBalance();

    return globalTransactionBalanceModel?.toEntity();
  }

  @override
  Future<Either<Failure, Map<int, GlobalBalance>?>> getBalanceByYear(
      {int? year}) async {
    final model = await _datasource.getBalancesByYear(year: year);

    return Right(model?.toEntityMap());
  }
}
