/// Test the Receipt Model
/// 1. Create the model in as many different ways as possible

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spending_tracker/models/receipt.dart';

void main() {
  /// Global receipt model to conduct tests on
  ReceiptModel model = ReceiptModel();

  test('Create an empty Receipt Model', () {
    /// All fields should be empty
    var testModel = ReceiptModel.empty();
    expect(testModel.store, isNull);
    expect(testModel.address, isNull);
    expect(testModel.category, isNull);
    expect(testModel.total, isNull);
    expect(testModel.date, isNull);
  });

  test('Create a receipt model from a json dictionary', () {
    var json = {
      "store": "Mock Store Name",
      "raw_text": ["This is fake raw text"],
      "total": 1137.20,
      "date": DateTime(2022, 02, 02),
      'address': 'Some address that passed validation',
    };

    final test_model = createJson(json: json);

    expect(test_model.address == json['address'], true, reason: 'address');
    expect(test_model.store == json['store'], true, reason: 'store');
    expect(test_model.total == json['total'], true, reason: 'total');
    expect(test_model.date == json['date'], true, reason: 'date');
    expect(test_model.rawText == json['raw_text'], true, reason: 'raw text');
    model = test_model;
  });
  testWidgets('Receipt List View test ', (WidgetTester tester) async {
    ///  Create a widget that updates whenever the store names value changes
    await tester.pumpWidget(MaterialApp(
      home: AnimatedBuilder(
          animation: model,
          builder: (context, child) {
            return Scaffold(body: Text('${model.store}'));
          }),
    ));

    /// Change store name and look for the new name
    model.setStore('new store name');
    await tester.pumpAndSettle();

    /// give the ui a second to update
    expect(find.text('new store name'), findsOneWidget);

    /// Change value again, verify that the old name is gone
    /// verify the new name is shown
    model.setStore('Another new name');
    await tester.pumpAndSettle();
    expect(find.text('new store name'), findsNothing);
    expect(find.text('Another new name'), findsOneWidget);
  });
}

ReceiptModel createJson({json}) {
  /// helper function for creating ReceiptModels from json
  var test_model = ReceiptModel.fromJson(json);
  return test_model;
}
