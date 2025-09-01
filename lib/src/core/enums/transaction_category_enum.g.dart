// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_category_enum.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionCategoryEnumAdapter extends TypeAdapter<ExpenseCategoryEnum> {
  @override
  final int typeId = 2;

  @override
  ExpenseCategoryEnum read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ExpenseCategoryEnum.food;
      case 1:
        return ExpenseCategoryEnum.tansportation;
      case 2:
        return ExpenseCategoryEnum.housing;
      case 3:
        return ExpenseCategoryEnum.utility;
      case 4:
        return ExpenseCategoryEnum.household;
      case 5:
        return ExpenseCategoryEnum.entertainment;
      default:
        return ExpenseCategoryEnum.food;
    }
  }

  @override
  void write(BinaryWriter writer, ExpenseCategoryEnum obj) {
    switch (obj) {
      case ExpenseCategoryEnum.food:
        writer.writeByte(0);
        break;
      case ExpenseCategoryEnum.tansportation:
        writer.writeByte(1);
        break;
      case ExpenseCategoryEnum.housing:
        writer.writeByte(2);
        break;
      case ExpenseCategoryEnum.utility:
        writer.writeByte(3);
        break;
      case ExpenseCategoryEnum.household:
        writer.writeByte(4);
        break;
      case ExpenseCategoryEnum.entertainment:
        writer.writeByte(5);
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
