import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spending_tracker/main.dart';
import 'utils.dart' as utils;

void main() async {
  final mockGlobalScope = GlobalScope(Container());
  group('Testing Graph Creation', () {
    testWidgets('No receipts', (WidgetTester tester) async {
      utils.resetMockGS(mockGlobalScope);
      await tester.pumpWidget(
        Material(
          child: mockGlobalScope,
        ),
        const Duration(seconds: 1),
      );
      final BuildContext context = tester.element(find.byType(GlobalScope));

      assert(GlobalScope.of(context)!.getReceipts().value.isEmpty);
    });
  });
}
