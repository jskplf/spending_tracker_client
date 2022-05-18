import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/receipt.dart';

/// This is the OCR API client

/// Take a list of files [result] and use the OCR Api to process them
/// return the results as a ReceiptModel
Future<ReceiptModel> getOCRResults(result) async {
  List<File> files;
  if (kIsWeb) {
    files = result.files.first.bytes;
  } else {
    files = result.paths.map<File>((path) => File('$path')).toList();
  }
  var req = http.MultipartRequest(
      'POST', Uri.parse('https://spendingtracker-ocr.herokuapp.com/ocr/'));
  var f = http.MultipartFile.fromBytes('files', await files[0].readAsBytes(),
      filename: 'aaaaaaa.jpg');
  req.files.add(f);
  var res = await req.send();
  var json = jsonDecode(await res.stream.bytesToString())['data'];
  // json = jsonDecode(json);
  return ReceiptModel.fromJson(json[0] as Map<String, dynamic>);
}
