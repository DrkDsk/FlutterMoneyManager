// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_summary_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FinancialSummaryHiveModelAdapter
    extends TypeAdapter<FinancialSummaryHiveModel> {
  @override
  final int typeId = 2;

  @override
  FinancialSummaryHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FinancialSummaryHiveModel(
      income: fields[0] as int,
      expense: fields[1] as int,
      netWorth: fields[2] as int,
      asset: fields[3] as int,
      balancesBySource: (fields[4] as Map).cast<String, int>(),
      debt: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, FinancialSummaryHiveModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.income)
      ..writeByte(1)
      ..write(obj.expense)
      ..writeByte(2)
      ..write(obj.netWorth)
      ..writeByte(3)
      ..write(obj.asset)
      ..writeByte(4)
      ..write(obj.balancesBySource)
      ..writeByte(5)
      ..write(obj.debt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FinancialSummaryHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
