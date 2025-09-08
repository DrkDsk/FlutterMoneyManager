import 'package:flutter_money_manager/src/core/constants/transactions_constants.dart';
import 'package:flutter_money_manager/src/core/shared/hive/data/models/global_balance_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_source_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';
import 'package:hive/hive.dart';

class TransactionDatasourceImpl implements TransactionDatasource {
  final Box<TransactionHiveModel> _transactionBox;
  final Box<TransactionSourceHiveModel> _transactionSourceBox;
  final Box<GlobalBalanceHiveModel> _globalBalanceBox;

  const TransactionDatasourceImpl(
      {required Box<TransactionHiveModel> transactionBox,
      required Box<TransactionSourceHiveModel> transactionSourceBox,
      required Box<GlobalBalanceHiveModel> globalBalanceModel})
      : _transactionBox = transactionBox,
        _transactionSourceBox = transactionSourceBox,
        _globalBalanceBox = globalBalanceModel;

  @override
  Future<bool> saveTransaction(Transaction transaction) async {
    final hiveModel = TransactionHiveModel.fromEntity(transaction);

    await _transactionBox.add(hiveModel);

    _updateGlobalBalanceRegister(transaction: transaction);

    return true;
  }

  Future<void> _updateGlobalBalanceRegister({
    required Transaction transaction,
  }) async {
    final isIncome = transaction.type == kIncomeType;
    final source = transaction.sourceType ?? "Unknown";

    final currentModel = _globalBalanceBox.get("summary");

    final baseBalance = currentModel ??
        GlobalBalanceHiveModel(
          income: 0,
          expense: 0,
          total: 0,
          asset: 0,
          debt: 0,
          balancesBySource: {},
        );

    final amount = transaction.amount;

    final newIncome = baseBalance.income + (isIncome ? amount : 0);
    final newExpense = baseBalance.expense + (!isIncome ? amount : 0);

    final newTotal = baseBalance.total + (isIncome ? amount : -amount);

    final Map<String, int> updatedSources =
        Map.from(baseBalance.balancesBySource);

    final currentSourceBalance = updatedSources[source] ?? 0;
    final newSourceBalance =
        currentSourceBalance + (isIncome ? amount : -amount);

    updatedSources[source] = newSourceBalance;

    final newAsset = updatedSources.entries
        .where((entry) => kPositiveTransactionSources.contains(entry.key))
        .fold<int>(
            0, (sum, entry) => sum + (entry.value < 0 ? 0 : entry.value));

    final newDebt = updatedSources.entries
        .where((entry) => kNegativeTransactionSources.contains(entry.key))
        .fold<int>(
            0,
            (sum, entry) =>
                sum + (entry.value < 0 ? -entry.value : entry.value));

    final updatedBalance = baseBalance.copyWith(
      income: newIncome,
      expense: newExpense,
      total: newTotal,
      asset: newAsset,
      debt: newDebt,
      balancesBySource: updatedSources,
    );

    await _globalBalanceBox.put("summary", updatedBalance);
  }

  @override
  Future<List<TransactionHiveModel>> getTransactionsModels(
      {required int monthIndex}) async {
    final values = _transactionBox.values.toList();

    final filtered = values.where((transaction) {
      return transaction.transactionDate.month == monthIndex;
    }).toList();

    return filtered;
  }

  @override
  Future<List<TransactionHiveModel>> getTransactionsModelsByDate(
      {required DateTime date}) async {
    final values = _transactionBox.values.toList();

    final filtered = values.where((transaction) {
      final tDate = transaction.transactionDate;
      return tDate.year == date.year &&
          tDate.month == date.month &&
          tDate.day == date.day;
    }).toList();

    return filtered;
  }

  @override
  Future<List<TransactionSourceHiveModel>> getTransactionSources() async {
    return _transactionSourceBox.values.toList();
  }

  @override
  Future<GlobalBalanceHiveModel?> getTransactionGlobalBalance() async {
    final globalTransactionBalance = _globalBalanceBox.get("summary");

    return globalTransactionBalance;
  }
}
