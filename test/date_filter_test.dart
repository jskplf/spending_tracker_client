import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Filter dates', () {
    DateTime startDate = fromString('12/30/10');
    DateTime endDate = fromString('01/01/20');

    test('Try valid dates', () {
      expect(startDate.isBefore(endDate), true);
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
      expect(() {
        fromString('odk/gjfso/fsdf');
      }, throwsA(TypeMatcher<FormatException>));
      expect(() {
        fromString('100/100/100');
      }, throwsFormatException);
    });
  });
}

DateTime fromString(String date) {
  assert(date.split('/').length == 3);
  dynamic s = date.split('/').map((e) {
    var x = int.tryParse(e);
    if (x == null) {
      throw FormatException;
    } else {
      return x;
    }
  }).toList();
  assert(s.length == 3);

  return DateTime(s[2], s[1], s[0]);
}
