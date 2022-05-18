import 'package:spending_tracker/models/receipt.dart';

DateTime fromString(String date) {
  assert(date.split('/').length == 3);
  dynamic s = date.split('/').map((e) {
    var x = int.tryParse(e);
    assert(x != null);
    return x;
  }).toList();
  assert(s.length == 3);
  assert(s[1] <= 31);
  assert(s[0] <= 12);
  return DateTime(s[2], s[0], s[1]);
}

List<ReceiptModel> filterByDates(
  /// Return a list of receipt models whose value for date is after the [startDate]
  /// and before the [endDate]

  String startDate,
  String endDate,
  List<ReceiptModel> receipts,
) {
  assert(receipts.isNotEmpty);
  assert(fromString(startDate).isBefore(fromString(endDate)));
  var sd = fromString(startDate);
  var ed = fromString(endDate);

  return receipts.where((element) {
    /// Ignore any receipt that has no date
    if (element.date == null) {
      return false;
    }

    var rDate = fromString(element.date);

    if (rDate.isBefore(sd) || rDate.isAfter(ed)) {
      return false;
    } else {
      return true;
    }
  }).toList();
}
