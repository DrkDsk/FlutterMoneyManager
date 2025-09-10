import 'dart:async';
import 'dart:isolate';

import 'package:dartz/dartz.dart';
import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';

import 'package:flutter_money_manager/src/core/error/exceptions/unknown_exception.dart';
import 'package:flutter_money_manager/src/core/error/failure/failure.dart';
import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/global_balance.dart';
import 'package:flutter_money_manager/src/features/accounts/domain/entities/account_balance.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
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
      final defaultDate = DateTime.now();
      final defaultMonth = month ?? defaultDate.month;
      final defaultYear = year ?? defaultDate.year;

      final models = await _datasource.getTransactionsModels(
          month: defaultMonth, year: defaultYear);

      final transactionsData = models.transactions.entries.map((entry) {
        final dateSplit = entry.key.split("-");
        final year = int.tryParse(dateSplit[2]) ?? defaultYear;
        final month = int.tryParse(dateSplit[1]) ?? defaultMonth;
        final day = int.tryParse(dateSplit[0]) ?? defaultDate.day;

        final date = DateTime(year, month, day);

        final transactions =
            entry.value.map((transaction) => transaction.toEntity()).toList();

        final data = TransactionsData(transactions: transactions, date: date);

        return data;
      }).toList();

      final monthBalance = await _datasource.getMonthBalances(
          month: defaultMonth, year: defaultYear);

      final transactionsBalance = TransactionBalance(
          transactionsData: transactionsData,
          income: monthBalance.income,
          total: monthBalance.total,
          expense: monthBalance.expense);

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

    final rawModels = models.map((element) => element.toJson()).toList();

    final balance = await Isolate.run(() {
      int income = 0;
      int expense = 0;

      final grouped = <DateTime, List<Map<String, dynamic>>>{};

      for (final raw in rawModels) {
        final dateFromMilliseconds =
            DateTime.fromMillisecondsSinceEpoch(raw['transactionDate']);

        final date = DateTime(dateFromMilliseconds.year,
            dateFromMilliseconds.month, dateFromMilliseconds.day);
        grouped.putIfAbsent(date, () => []).add(raw);
      }

      final transactionsData = grouped.entries.map((entry) {
        final transactions = entry.value.map((raw) {
          final id = raw["id"] as String;
          final amount = (raw["amount"] as num).toInt();

          final transactionTypeName = raw['type'] as String;
          final transactionType = transactionTypeName == kIncomeType
              ? TransactionTypEnum.income
              : TransactionTypEnum.expense;
          final categoryType = raw["categoryType"] as String;
          final sourceType = raw["sourceType"] as String;
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
          if (transaction.type == TransactionTypEnum.income) {
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

    _transactionsController.add(balance);

    return Right(balance);
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

    final defaultTransactionSource = kDefaultTransactionSources
        .map((transactionSource) =>
            AccountBalance(transactionSource: transactionSource, amount: 0))
        .toList();

    result.addAll(defaultTransactionSource);

    return Right(result);
  }

  @override
  Future<GlobalBalance?> getGlobalTransactionsBalance() async {
    final globalTransactionBalanceModel =
        await _datasource.getTransactionGlobalBalance();

    return globalTransactionBalanceModel?.toEntity();
  }

  @override
  Future<Either<Failure, Map<int, GlobalBalance>?>> getTransactionsByYear(
      {int? year}) async {
    final model = await _datasource.getBalancesByYear(year: year);

    return Right(model?.toEntityMap());
  }
}
