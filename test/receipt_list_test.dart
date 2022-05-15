// /// tests to check if the receipt list view is working correctly
// /// 1. check if list has the correct number of elements
// /// 2. check if each tile has the correct values
// /// 3. check if each tile navigates to the correct receipt view when tapped

// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:spending_tracker/models/receipt.dart';
// import 'package:spending_tracker/views/views.dart';

// /// Global array of receipts that will update when altered(both adding to list and editing individual elements of the list)
// ValueNotifier<List> receipts =
//     ValueNotifier([ReceiptModel(), ReceiptModel(), ReceiptModel()]);

// void main() {
//   group('Receipt List view Test', () {
//     testWidgets('ReceiptModel ListenerBuilder test ',
//         (WidgetTester tester) async {
//       ///  Create a widget that updates whenever the store names value changes
//       await tester.pumpWidget(MaterialApp(
//         home: AnimatedBuilder(
//             animation: receipts,
//             builder: (context, child) {
//               return Scaffold(body: ReceiptList(r: receipts.value));
//             }),
//       ));

//       /// Change store name and look for the new name
//       receipts.value[0].setStore('new store name');
//       receipts.notifyListeners();
//       await tester.pumpAndSettle();

//       /// give the ui a second to update
//       expect(find.text('new store name'), findsOneWidget);

//       /// Change value again, verify that the old name is gone
//       /// verify the new name is shown
//       receipts.value[0].setStore('Another new name');
//       receipts.notifyListeners();
//       await tester.pumpAndSettle();
//       // expect(find.text('new store name'), findsNothing);
//       expect(find.text('Another new name'), findsOneWidget);
//     });

//     testWidgets('Add a receipt to the list of receipts',
//         (WidgetTester tester) async {
//       await tester.pumpWidget(MaterialApp(
//         home: AnimatedBuilder(
//             animation: receipts,
//             builder: (context, child) {
//               return Scaffold(body: ReceiptList(r: receipts.value));
//             }),
//       ));
//       receipts.value.add(ReceiptModel(store: 'Added this afterwards'));
//       receipts.notifyListeners();
//       await tester.pumpAndSettle();

//       /// Check to see that a new tile was created and it contains the correct
//       /// text
//       expect(find.text('Added this afterwards'), findsOneWidget);
//       expect(receipts.value.length == 4, true);
//       expect(find.byType(ReadableTile), findsNWidgets(4));
//     });
//   });
// }
