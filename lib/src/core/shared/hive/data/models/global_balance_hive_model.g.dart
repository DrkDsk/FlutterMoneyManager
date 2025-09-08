// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_balance_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GlobalBalanceHiveModelAdapter
    extends TypeAdapter<GlobalBalanceHiveModel> {
  @override
  final int typeId = 2;

  @override
  GlobalBalanceHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GlobalBalanceHiveModel(
      income: fields[0] as int,
      expense: fields[1] as int,
      total: fields[2] as int,
      asset: fields[3] as int,
      balancesBySource: (fields[4] as Map?)?.cast<String, int>(),
    );
  }

  @override
  void write(BinaryWriter writer, GlobalBalanceHiveModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.income)
      ..writeByte(1)
      ..write(obj.expense)
      ..writeByte(2)
      ..write(obj.total)
      ..writeByte(3)
      ..write(obj.asset)
      ..writeByte(4)
      ..write(obj.balancesBySource);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GlobalBalanceHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
