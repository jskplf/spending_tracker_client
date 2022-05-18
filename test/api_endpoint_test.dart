import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() async {
  test('Api endpoint can be reached', () async {
    var resp =
        await http.get(Uri.parse('https://spendingtracker-ocr.herokuapp.com/'));
    expect(resp.statusCode, 200);
  });
}
