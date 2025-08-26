import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction.dart';

abstract interface class TransactionDatasource {
  Future<bool> saveTransaction(Transaction dto);
}
