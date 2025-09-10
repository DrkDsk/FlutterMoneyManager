// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'yearly_financial_summary_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class YearlyFinancialSummaryHiveModelAdapter
    extends TypeAdapter<YearlyFinancialSummaryHiveModel> {
  @override
  final int typeId = 4;

  @override
  YearlyFinancialSummaryHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return YearlyFinancialSummaryHiveModel(
      year: fields[0] as int,
      months: (fields[1] as List).cast<MonthlyFinancialSummaryHiveModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, YearlyFinancialSummaryHiveModel obj) {
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
      other is YearlyFinancialSummaryHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
