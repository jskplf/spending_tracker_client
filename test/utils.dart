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
