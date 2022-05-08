import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

/// This is the OCR API client
/// it has methods to connect to the fastapi endpoints of the api
Future<dynamic> getFakeRequest() async {
  /// Fake http request returns a Map after 4 seconds
  await Future.delayed(const Duration(seconds: 4));
  return {
    "status_code": 200,
    "data": ['some data...']
  };
}

/// Take a list of files and use the OCR Api to process them, return the results
Future<dynamic> getOCRResults(result) async {
  List<File> files = result.paths.map<File>((path) => File('$path')).toList();
  var req = http.MultipartRequest(
      'POST', Uri.parse('https://spendingtracker-ocr.herokuapp.com/ocr/'));
  var f = http.MultipartFile.fromBytes('files', await files[0].readAsBytes(),
      filename: files[0].path.split("/").last);
  req.files.add(f);
  var res = await req.send();
  return jsonDecode(await res.stream.bytesToString());
}
