// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionHiveModelAdapter extends TypeAdapter<TransactionHiveModel> {
  @override
  final int typeId = 0;

  @override
  TransactionHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionHiveModel(
      id: fields[0] as String,
      type: fields[1] as TransactionTypeEnum,
      transactionDate: fields[2] as DateTime,
      amount: fields[3] as int,
      categoryType: fields[4] as TransactionCategoryEnum,
      sourceType: fields[5] as PaymentSourceEnum,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionHiveModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.transactionDate)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.categoryType)
      ..writeByte(5)
      ..write(obj.sourceType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
