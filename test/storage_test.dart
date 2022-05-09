import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:spending_tracker/services/storage.dart';

/// Test to make that the function calls to local storage are working correctly
/// 1. hive can save a receipt
/// 2. hive can delete a receipt
/// 3. hive can get a receipt from an index
///
void main() {
  test('Hive can save a receipt', () async {
    var box = await Hive.openBox('receipts');
    
  });
}
