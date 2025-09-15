// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_transactions_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MonthlyTransactionsHiveModelAdapter
    extends TypeAdapter<MonthlyTransactionsHiveModel> {
  @override
  final int typeId = 5;

  @override
  MonthlyTransactionsHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MonthlyTransactionsHiveModel(
      month: fields[0] as int,
      transactions: (fields[1] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List).cast<TransactionHiveModel>())),
    );
  }

  @override
  void write(BinaryWriter writer, MonthlyTransactionsHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.month)
      ..writeByte(1)
      ..write(obj.transactions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MonthlyTransactionsHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
