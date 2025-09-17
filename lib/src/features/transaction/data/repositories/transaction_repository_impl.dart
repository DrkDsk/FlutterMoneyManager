import 'dart:async';
import 'dart:isolate';

import 'package:dartz/dartz.dart';
import 'package:flutter_money_manager/src/core/constants/hive_constants.dart';
import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/core/enums/transaction_type_enum.dart';

import 'package:flutter_money_manager/src/core/error/exceptions/unknown_exception.dart';
import 'package:flutter_money_manager/src/core/error/failure/failure.dart';
import 'package:flutter_money_manager/src/core/helpers/datetime_helper.dart';
import 'package:flutter_money_manager/src/core/helpers/hive_helper.dart';
import 'package:flutter_money_manager/src/core/shared/hive/data/models/financial_summary_model.dart';
import 'package:flutter_money_manager/src/core/shared/hive/domain/entities/financial_summary.dart';
import 'package:flutter_money_manager/src/features/accounts/domain/entities/account_summary_item.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/DTO/transaction_dto.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/DTO/yearly_transactions_dto.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/hive/transaction_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/monthly_transactions_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/yearly_financial_summary_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/yearly_transactions_model.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transactions_summary.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_source.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transactions_data.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/services/financial_calculator_service.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionDatasource _datasource;
  final _transactionsController =
      StreamController<TransactionsSummary>.broadcast();

  TransactionRepositoryImpl({required TransactionDatasource datasource})
      : _datasource = datasource;

  @override
  Future<Either<Failure, bool>> save(Transaction transaction) async {
    try {
      final date = transaction.transactionDate;
      final year = date.year;

      final yearlyTransactionKey =
          HiveHelper.generateYearlyTransactionKey(year: year);

      final yearlyBalanceKey = HiveHelper.generateYearlyBalanceKey(year: year);

      YearlyTransactionsModel currentYearlyTransactionsModel =
          await _datasource.getYearlyTransactions(key: yearlyTransactionKey) ??
              YearlyTransactionsModel.initial(year: year);

      final updatedYearlyTransactions =
          FinancialCalculatorService.updateYearlyTransactionHiveModel(
              yearlyTransactions: currentYearlyTransactionsModel.toEntity(),
              transaction: transaction);

      currentYearlyTransactionsModel =
          YearlyTransactionsModel.fromEntity(updatedYearlyTransactions);

      await _datasource.save(
          model: currentYearlyTransactionsModel, key: yearlyTransactionKey);

      YearlyFinancialSummaryModel yearlyFinancialSummaryCurrentModel =
          await _datasource.getBalancesByYear(key: yearlyBalanceKey) ??
              YearlyFinancialSummaryModel.initial(year: year);

      final updatedYearlyFinancialSummary =
          FinancialCalculatorService.updateYearlyFinancialSummary(
              transaction: transaction,
              yearlyFinancialSummary:
                  yearlyFinancialSummaryCurrentModel.toEntity());

      yearlyFinancialSummaryCurrentModel =
          YearlyFinancialSummaryModel.fromEntity(updatedYearlyFinancialSummary);

      await _datasource.saveYearFinancialSummary(
          model: yearlyFinancialSummaryCurrentModel, key: yearlyBalanceKey);

      FinancialSummaryModel financialSummaryModel = await _datasource
              .getGlobalFinancialSummary(key: HiveConstants.globalSummaryKey) ??
          FinancialSummaryModel.initial();

      final updatedGlobalFinancial =
          FinancialCalculatorService.updateGlobalSummary(
              transaction: transaction,
              financialSummary: financialSummaryModel.toEntity());

      financialSummaryModel =
          FinancialSummaryModel.fromEntity(updatedGlobalFinancial);

      await _datasource.saveFinancialSummary(
          model: financialSummaryModel, key: HiveConstants.globalSummaryKey);

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

      final yearlyTransactionsKey =
          HiveHelper.generateYearlyTransactionKey(year: year);

      final yearlyBalanceKey = HiveHelper.generateYearlyBalanceKey(year: year);

      final emptyTransaction = TransactionsSummary.initial();

      final yearlyTransactions =
          await _datasource.getYearlyTransactions(key: yearlyTransactionsKey);

      final monthTransactions = yearlyTransactions?.months
          .where((monthTransaction) => monthTransaction.month == month)
          .toList();

      if (monthTransactions == null || monthTransactions.isEmpty) {
        return Right(emptyTransaction);
      }

      final transactionsModelsMonth = monthTransactions.first.transactions;

      final yearlyBalances =
          await _datasource.getBalancesByYear(key: yearlyBalanceKey);

      if (yearlyBalances == null) {
        return Right(emptyTransaction);
      }

      final balances = yearlyBalances.months
          .where((monthBalance) => monthBalance.month == month)
          .toList();

      if (balances.isEmpty) {
        return Right(emptyTransaction);
      }

      final monthBalance = balances.first.summary;

      final transactionsBalance = await Isolate.run(() {
        final transactionsData = transactionsModelsMonth.entries.map((entry) {
          final date = DatetimeHelper.parse(input: entry.key);
          final transactions = entry.value.map((t) => t.toEntity()).toList();
          return TransactionsData(transactions: transactions, date: date);
        }).toList();

        return TransactionsSummary(
          transactionsData: transactionsData,
          income: monthBalance.income,
          total: monthBalance.netWorth,
          expense: monthBalance.expense,
        );
      });

      return Right(transactionsBalance);
    } on UnknownException catch (_) {
      return Left(GenericFailure());
    } catch (e) {
      return Left(GenericFailure());
    }
  }

  @override
  Future<Either<Failure, TransactionsSummary>> getTransactionsByDate(
      {required DateTime date}) async {
    final month = date.month;
    final yearlyKey = HiveHelper.generateYearlyTransactionKey(year: date.year);
    final transactionDayKey = HiveHelper.generateTransactionDayKey(date: date);

    final yearlyModels =
        await _datasource.getYearlyTransactions(key: yearlyKey);

    if (yearlyModels == null) {
      return Right(TransactionsSummary.initial());
    }

    final monthTransaction = (yearlyModels.months).firstWhere(
      (m) => m.month == month,
      orElse: () => MonthlyTransactionsModel.initial(month: month),
    );

    final models = monthTransaction.transactions[transactionDayKey] ?? [];
    final rawModels = models.map((model) => model.toMap()).toList();
    final grouped = {date: rawModels};

    int income = 0;
    int expense = 0;

    final transactionData = await Isolate.run(() {
      final transactionsModelsRaw = (grouped[date] ?? []).toList();

      final transactions = transactionsModelsRaw.map((entry) {
        final transactionModel = TransactionHiveModel.fromMap(entry);
        return transactionModel.toDTO().toModel().toEntity();
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

    final TransactionsSummary transactionBalance = TransactionsSummary(
        transactionsData: [transactionData],
        income: income,
        total: income - expense,
        expense: expense);

    _transactionsController.add(transactionBalance);

    return Right(transactionBalance);
  }

  @override
  Future<Either<Failure, List<AccountSummaryItem>>>
      getTransactionSources() async {
    final transactionsSourceModels = await _datasource.getTransactionSources();

    final modelsRaw =
        transactionsSourceModels.map((model) => model.toJson()).toList();

    final result = await Isolate.run(() {
      final data = modelsRaw.map((source) {
        final name = source["name"] as String;
        final icon = source["icon"] as String;

        final transactionSource = TransactionSource(name: name, icon: icon);
        const amount = 0;

        return AccountSummaryItem(
            transactionSource: transactionSource, amount: amount);
      }).toList();

      return data;
    });

    final defaultTransactionSource = TransactionsConstants
        .kDefaultTransactionSources
        .map((transactionSource) =>
            AccountSummaryItem(transactionSource: transactionSource, amount: 0))
        .toList();

    result.addAll(defaultTransactionSource);

    return Right(result);
  }

  @override
  Future<FinancialSummary> getGlobalFinancialSummary() async {
    final globalTransactionBalanceModel = await _datasource
            .getGlobalFinancialSummary(key: HiveConstants.globalSummaryKey) ??
        FinancialSummaryModel.initial();

    return globalTransactionBalanceModel.toEntity();
  }
}
