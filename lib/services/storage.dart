import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// This manages how data is saved int he app
/// For right now the application uses [Hive](https://pub.dev/packages/hive)

List getReceipts() {
  /// Returns the all the receipts save in the application
  /// will auto update when value changes
  var box = Hive.box('receipts');
  var out = box.get('data');
  if (out == null) {
    box.put('data', []);
    out = box.get('data');
  }
  return out;
}

void saveReceipt(Map receipt) {
  /// Add a new receipt to the hive box

  /// Load the current list of receipts
  var box = Hive.box('receipts');

  List original = box.get('receipts');
  original.insert(0, receipt);
  box.put('receipts', original);
}
