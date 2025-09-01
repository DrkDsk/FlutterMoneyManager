// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_source_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentSourceEnumAdapter extends TypeAdapter<PaymentSourceEnum> {
  @override
  final int typeId = 3;

  @override
  PaymentSourceEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PaymentSourceEnum.carLoan;
      case 1:
        return PaymentSourceEnum.investments;
      case 2:
        return PaymentSourceEnum.bank;
      case 3:
        return PaymentSourceEnum.cash;
      case 4:
        return PaymentSourceEnum.creditCard;
      case 5:
        return PaymentSourceEnum.debitCard;
      case 6:
        return PaymentSourceEnum.electricMoney;
      default:
        return PaymentSourceEnum.carLoan;
    }
  }

  @override
  void write(BinaryWriter writer, PaymentSourceEnum obj) {
    switch (obj) {
      case PaymentSourceEnum.carLoan:
        writer.writeByte(0);
        break;
      case PaymentSourceEnum.investments:
        writer.writeByte(1);
        break;
      case PaymentSourceEnum.bank:
        writer.writeByte(2);
        break;
      case PaymentSourceEnum.cash:
        writer.writeByte(3);
        break;
      case PaymentSourceEnum.creditCard:
        writer.writeByte(4);
        break;
      case PaymentSourceEnum.debitCard:
        writer.writeByte(5);
        break;
      case PaymentSourceEnum.electricMoney:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentSourceEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
