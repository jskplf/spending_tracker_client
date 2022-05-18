import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:spending_tracker/main.dart';
import 'package:spending_tracker/models/receipt.dart';

void resetMockGS(mockGlobalScope) {
  /// Creates a Global Scope identical to a fresh install
  for (int i = 0; i < mockGlobalScope.length; i++) {
    mockGlobalScope.deleteReceipt(i);
  }

  assert(mockGlobalScope.getReceipts().value.isEmpty);
}

void mockLoadGS(mockGlobalScope) {
  resetMockGS(mockGlobalScope);
  var fakeData = [
    ReceiptModel(
      store: 'Mock Store 1',
      address: 'NY 11111',
      date: '10/10/10',
      category: 'Mock Cat 1',
      total: '15.00',
    ),
    ReceiptModel(
      store: 'Mock Store 2',
      address: 'NY 11112',
      date: '10/10/11',
      category: 'Mock Cat 3',
      total: '15.00',
    ),
    ReceiptModel(
      store: 'Mock Store 3',
      address: 'NY 11113',
      date: '10/10/09',
      category: 'Mock Cat 3',
      total: '15.00',
    ),
  ];
  for (var element in fakeData) {
    mockGlobalScope.addReceipt(element);
  }
}

void main() async {
  final mockGlobalScope = GlobalScope(Container());
  // await GetStorage.init();

  /// Create a fake instance of the application runtime
  /// 1. Test that user can add, delete, and view receipts
  ///   input - Empty list
  ///   output - read -> empty List, delete -> error, add -> nothing
  ///
  ///   input - list with one item
  ///   output - read -> list containing item, delete -> nothing(zero items), add-> nothing
  group('Load receipts from local storage, test adding, editing and deleting',
      () {
    /// Initialize the receipts value in global scope to an empty list to mock a fresh install
    testWidgets('View,Add,Edit,Delete receipts when there are no receipts',
        (WidgetTester tester) async {
      /// Start with no receipts and see if the app can handle it
      resetMockGS(mockGlobalScope);
      await tester.pumpWidget(
        Material(
          child: mockGlobalScope,
        ),
        const Duration(seconds: 1),
      );
      final BuildContext context = tester.element(find.byType(GlobalScope));

      // expect(GlobalScope.of(context)!.getReceipts(), returnsNormally);
      expect(GlobalScope.of(context)!.getReceipts().value, [],
          reason: 'Fresh install starts with empty an empty database');

      expect(() => GlobalScope.of(context)!.getReceipt(0),
          throwsA(isA<RangeError>()));

      expect(() => GlobalScope.of(context)!.deleteReceipt(0),
          throwsA(TypeMatcher<IndexError>()),
          reason: 'There are no receipts for the user to delete');
      // Add a receipt
      expect(() => GlobalScope.of(context)!.addReceipt(ReceiptModel.empty()),
          returnsNormally);

      expect(() => GlobalScope.of(context)!.getReceipt(0), returnsNormally);

      // Check if the list of receipts has grown by one
      expect(GlobalScope.of(context)!.receipts.value.length, 1);

      mockLoadGS(mockGlobalScope);
      expect(GlobalScope.of(context)!.length, 3);

      /// Mock loading a previously used version of the app
      await tester.pumpWidget(
          Material(
            child: mockGlobalScope,
          ),
          const Duration(seconds: 1));

      expect(GlobalScope.of(context)!.length, 3);

      expect(
          () => GlobalScope.of(context)!
              .editReceipt(0, ReceiptModel(store: 'Mock Store 4')),
          returnsNormally);
      expect(GlobalScope.of(context)!.getReceipt(0).store, 'Mock Store 4');
    });
  });
}
