import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:spending_tracker/views/views.dart';
import 'package:spending_tracker/widgets/custom_nav_bar.dart';
import 'package:http/http.dart' as http;

import '../widgets/readable.dart';

class ImageLoaderView extends StatelessWidget {
  /// This screen allows the user to select an image from their device by
  const ImageLoaderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavBar(),
      appBar: AppBar(
        title: Readable(
          text: 'Load Receipt',
        ),
      ),
      body: Center(
        child: LoadImageButton(),
      ),
    );
  }
}

class LoadImageButton extends StatelessWidget {
  const LoadImageButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        FilePickerResult? result = await FilePicker.platform
            .pickFiles(allowMultiple: true, type: FileType.image);
        if (result != null) {
          List<File> files = result.paths.map((path) => File('$path')).toList();
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: InteractiveViewer(
                  child: Image.memory(files[0].readAsBytesSync()),
                ),
              );
            },
          );
          //final file = result.files.single;

          /// Use ocr api to find out get some auto fill suggestions
          //var request = http.MultipartRequest(
          //  'POST', Uri.parse('http://localhost:8000/ocr/'));

          //var response = await request.send();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ReceiptView(),
            ),
          );
        }
      },
      child: const Readable(text: 'Load Receipt'),
    );
  }
}
