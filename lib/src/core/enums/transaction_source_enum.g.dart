// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_source_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionSourceEnumAdapter extends TypeAdapter<TransactionSourceEnum> {
  @override
  final int typeId = 3;

  @override
  TransactionSourceEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TransactionSourceEnum.carLoan;
      case 1:
        return TransactionSourceEnum.investments;
      case 2:
        return TransactionSourceEnum.bank;
      case 3:
        return TransactionSourceEnum.cash;
      case 4:
        return TransactionSourceEnum.creditCard;
      case 5:
        return TransactionSourceEnum.debitCard;
      case 6:
        return TransactionSourceEnum.electricMoney;
      default:
        return TransactionSourceEnum.carLoan;
    }
  }

  @override
  void write(BinaryWriter writer, TransactionSourceEnum obj) {
    switch (obj) {
      case TransactionSourceEnum.carLoan:
        writer.writeByte(0);
        break;
      case TransactionSourceEnum.investments:
        writer.writeByte(1);
        break;
      case TransactionSourceEnum.bank:
        writer.writeByte(2);
        break;
      case TransactionSourceEnum.cash:
        writer.writeByte(3);
        break;
      case TransactionSourceEnum.creditCard:
        writer.writeByte(4);
        break;
      case TransactionSourceEnum.debitCard:
        writer.writeByte(5);
        break;
      case TransactionSourceEnum.electricMoney:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionSourceEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
