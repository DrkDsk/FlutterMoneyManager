// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_year_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionsYearHiveModelAdapter
    extends TypeAdapter<TransactionsYearHiveModel> {
  @override
  final int typeId = 6;

  @override
  TransactionsYearHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionsYearHiveModel(
      year: fields[0] as int,
      months: (fields[1] as List).cast<TransactionsMonthHiveModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, TransactionsYearHiveModel obj) {
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
      other is TransactionsYearHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
