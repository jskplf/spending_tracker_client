/// Test the dart wrapper around the OCR endpoint api
/// 1. user can send garbage data(something that is not a)
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:spending_tracker/services/api.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Send and image and receive the back ocr results', () async {
    var x = await getOCRResults(
      File.(
          'https://forum.ih8mud.com/media/tire-receipt.65705/full?d=1517357219'),
    );
    print('$x');
    expect(true, false);
  });
}
