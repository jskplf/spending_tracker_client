import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../models/receipt.dart';

/// This is the OCR API client
/// it simulates a network request by putting the thread to sleep for 4 seconds
/// it returns a [Future<Map>] with a key value pair of status_code : 200
Future<dynamic> getFakeRequest() async {
  /// Fake http request returns a Map after 4 seconds
  await Future.delayed(const Duration(seconds: 4));
  return {
    "status_code": 200,
    "data": ['some data...']
  };
}

/// Take a list of files [result] and use the OCR Api to process them
/// return the results as a ReceiptModel
Future<ReceiptModel> getOCRResults(result) async {
  List<File> files = result.paths.map<File>((path) => File('$path')).toList();
  var req = http.MultipartRequest(
      'POST', Uri.parse('https://spendingtracker-ocr.herokuapp.com/ocr/'));
  var f = http.MultipartFile.fromBytes('files', await files[0].readAsBytes(),
      filename: files[0].path.split("/").last);
  req.files.add(f);
  var res = await req.send();
  var json = jsonDecode(await res.stream.bytesToString())['data'];
  // json = jsonDecode(json);
  print(json[0]['parsed_date']);
  return ReceiptModel.fromJson(json[0] as Map<String, dynamic>);
}
