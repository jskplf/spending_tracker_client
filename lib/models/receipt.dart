import 'package:hive_flutter/hive_flutter.dart';

/// The receipt Model
/// it extends the Hive model class and inherits the save and delete methods
/// it has json serializers
@HiveType(typeId: 0)
class ReceiptModel extends HiveObject {
  @HiveField(0)
  String? store;

  @HiveField(1)
  String? address;

  @HiveField(2)
  DateTime? date;

  @HiveField(3)
  double? total;

  @HiveField(4)
  String? category;

  ReceiptModel.empty();

  ReceiptModel.fromJson(Map<String, dynamic> json)
      : store = json['store'],
        address = json['address'],
        date = json['date'],
        total = json['total'];

  Map<String, dynamic> toJson() => {
        'store': store,
        'address': address,
        'date': date,
        'total': total,
        'category': category,
      };
}
