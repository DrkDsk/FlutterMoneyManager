import 'package:flutter_money_manager/src/features/transaction/data/datasources/transaction_datasource.dart';
import 'package:flutter_money_manager/src/features/transaction/data/models/transaction_hive_model.dart';
import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';
import 'package:hive/hive.dart';

class TransactionDatasourceImpl implements TransactionDatasource {
  final Box<TransactionHiveModel> _box;

  const TransactionDatasourceImpl({required Box<TransactionHiveModel> box})
      : _box = box;

  @override
  Future<bool> saveTransaction(Transaction transaction) async {
    final hiveModel = TransactionHiveModel.fromEntity(transaction);

    await _box.add(hiveModel);
    return true;
  }

  @override
  Future<List<TransactionHiveModel>> getTransactionsModels() async {
    return _box.values.toList();
  }
}
