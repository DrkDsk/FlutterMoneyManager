// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_month_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionsMonthHiveModelAdapter
    extends TypeAdapter<TransactionsMonthHiveModel> {
  @override
  final int typeId = 5;

  @override
  TransactionsMonthHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionsMonthHiveModel(
      month: fields[0] as int,
      transactions: (fields[1] as List).cast<TransactionHiveModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, TransactionsMonthHiveModel obj) {
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
      other is TransactionsMonthHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
