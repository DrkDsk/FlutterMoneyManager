// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'month_balance_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MonthBalanceHiveModelAdapter extends TypeAdapter<MonthBalanceHiveModel> {
  @override
  final int typeId = 3;

  @override
  MonthBalanceHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MonthBalanceHiveModel(
      month: fields[0] as int,
      balance: fields[1] as GlobalBalanceHiveModel,
    );
  }

  @override
  void write(BinaryWriter writer, MonthBalanceHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.month)
      ..writeByte(1)
      ..write(obj.balance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MonthBalanceHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
