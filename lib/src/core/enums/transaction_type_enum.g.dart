// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_type_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionTypeEnumAdapter extends TypeAdapter<TransactionTypeEnum> {
  @override
  final int typeId = 1;

  @override
  TransactionTypeEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TransactionTypeEnum.income;
      case 1:
        return TransactionTypeEnum.expense;
      default:
        return TransactionTypeEnum.income;
    }
  }

  @override
  void write(BinaryWriter writer, TransactionTypeEnum obj) {
    switch (obj) {
      case TransactionTypeEnum.income:
        writer.writeByte(0);
        break;
      case TransactionTypeEnum.expense:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionTypeEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
