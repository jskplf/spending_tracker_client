import 'package:flutter_test/flutter_test.dart';
import 'package:spending_tracker/date_utils.dart';
import 'package:spending_tracker/models/receipt.dart';

void main() {
  group('Filter dates', () {
    test('Try valid dates', () {
      var x = fromString('10/11/12');
      expect(x.month, 10);
      expect(x.day, 11);
      expect(x.year, 12);
    });

    test('Try to convert a date that is empty', () {
      expect(() {
        fromString('');
      }, throwsAssertionError);
    });
    test('Try bad strings', () {
      expect(() {
        fromString('odkoksofk');
      }, throwsAssertionError);
      expect(() => fromString('odk/gjfso/fsdf'), throwsAssertionError);
      expect(() => fromString('100/100/100'), throwsAssertionError);
      expect(() => fromString('100/aaa/100'), throwsAssertionError);
    });
  });

  test('Filter a list of receipts with good data', () {
    String startDate = '10/10/01';
    String endDate = '10/10/20';
    List<ReceiptModel> x = [
      ReceiptModel(date: '10/10/01'),
      ReceiptModel(date: '9/01/00'),
    ];
    expect(() => filterByDates(startDate, endDate, x), returnsNormally);
    expect(filterByDates(startDate, endDate, x).length, 1);
  });

  test('Try to filter an empty list of receipts', () {
    String startDate = '10/10/01';
    String endDate = '10/10/20';
    List<ReceiptModel> x = [];
    expect(() => filterByDates(startDate, endDate, x), throwsAssertionError);
  });
  test('Try to filter a list with receipts where dates are invalid', () {
    String startDate = '10/10/01';
    String endDate = '10/10/20';
    List<ReceiptModel> x = [
      ReceiptModel(date: '10/10/01'),
      ReceiptModel(),
    ];
    expect(filterByDates(startDate, endDate, x).length, 1);
  });
}
