import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter_money_manager/src/features/transaction/domain/entities/transaction_source.dart';

part 'transaction_source_hive_model.g.dart';

@HiveType(typeId: 1)
class TransactionSourceHiveModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String icon;

  TransactionSourceHiveModel({
    required this.id,
    required this.name,
    required this.icon,
  });

  TransactionSourceHiveModel copyWith({
    String? id,
    String? name,
    String? icon,
  }) {
    return TransactionSourceHiveModel(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
    );
  }

  TransactionSource toEntity() {
    return TransactionSource(name: name, icon: icon);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
      };

  factory TransactionSourceHiveModel.fromEntity(TransactionSource entity) {
    return TransactionSourceHiveModel(
        id: entity.id ?? const Uuid().v4(),
        name: entity.name,
        icon: entity.icon);
  }
}
