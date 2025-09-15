// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monthly_financial_summary_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MonthlyFinancialSummaryHiveModelAdapter
    extends TypeAdapter<MonthlyFinancialSummaryHiveModel> {
  @override
  final int typeId = 3;

  @override
  MonthlyFinancialSummaryHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MonthlyFinancialSummaryHiveModel(
      month: fields[0] as int,
      summary: fields[1] as FinancialSummaryHiveModel,
    );
  }

  @override
  void write(BinaryWriter writer, MonthlyFinancialSummaryHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.month)
      ..writeByte(1)
      ..write(obj.summary);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MonthlyFinancialSummaryHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
