// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_category_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionCategoryEnumAdapter
    extends TypeAdapter<TransactionCategoryEnum> {
  @override
  final int typeId = 2;

  @override
  TransactionCategoryEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TransactionCategoryEnum.food;
      case 1:
        return TransactionCategoryEnum.tansportation;
      case 2:
        return TransactionCategoryEnum.housing;
      case 3:
        return TransactionCategoryEnum.utility;
      case 4:
        return TransactionCategoryEnum.household;
      case 5:
        return TransactionCategoryEnum.entertainment;
      case 6:
        return TransactionCategoryEnum.salary;
      case 7:
        return TransactionCategoryEnum.bonus;
      case 8:
        return TransactionCategoryEnum.sidebusiness;
      case 9:
        return TransactionCategoryEnum.investments;
      default:
        return TransactionCategoryEnum.food;
    }
  }

  @override
  void write(BinaryWriter writer, TransactionCategoryEnum obj) {
    switch (obj) {
      case TransactionCategoryEnum.food:
        writer.writeByte(0);
        break;
      case TransactionCategoryEnum.tansportation:
        writer.writeByte(1);
        break;
      case TransactionCategoryEnum.housing:
        writer.writeByte(2);
        break;
      case TransactionCategoryEnum.utility:
        writer.writeByte(3);
        break;
      case TransactionCategoryEnum.household:
        writer.writeByte(4);
        break;
      case TransactionCategoryEnum.entertainment:
        writer.writeByte(5);
        break;
      case TransactionCategoryEnum.salary:
        writer.writeByte(6);
        break;
      case TransactionCategoryEnum.bonus:
        writer.writeByte(7);
        break;
      case TransactionCategoryEnum.sidebusiness:
        writer.writeByte(8);
        break;
      case TransactionCategoryEnum.investments:
        writer.writeByte(9);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionCategoryEnumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
