// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'year_balance_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class YearBalanceHiveModelAdapter extends TypeAdapter<YearBalanceHiveModel> {
  @override
  final int typeId = 4;

  @override
  YearBalanceHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return YearBalanceHiveModel(
      year: fields[0] as int,
      months: (fields[1] as List).cast<MonthBalanceHiveModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, YearBalanceHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.year)
      ..writeByte(1)
      ..write(obj.months);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is YearBalanceHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
