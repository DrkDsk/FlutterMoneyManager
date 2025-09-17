import 'package:hive_flutter/hive_flutter.dart';

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

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon": icon,
      };
}
