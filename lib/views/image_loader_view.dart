import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:spending_tracker/services/storage.dart';
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
      body: const Center(
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
          var req = http.MultipartRequest('POST',
              Uri.parse('https://spendingtracker-ocr.herokuapp.com/ocr/'));
          var f = http.MultipartFile.fromBytes(
              'files', await files[0].readAsBytes(),
              filename: files[0].path.split("/").last);
          req.files.add(f);
          var res = await req.send();

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FutureBuilder(
                future: res.stream.bytesToString(),
                builder: (context, AsyncSnapshot snapshot) {
                  // Checking if future is resolved or not
                  if (snapshot.connectionState == ConnectionState.done) {
                    // If we got an error
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          '${snapshot.error} occurred',
                        ),
                      );

                      // if we got our data
                    } else if (snapshot.hasData) {
                      // Extracting data from snapshot object
                      final data = snapshot.data;
                      saveReceipt(receipt: jsonDecode(data));
                      return Center(
                        child: ReceiptView(),
                      );
                    }
                  }

                  // Displaying LoadingSpinner to indicate waiting state
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          );
        }
      },
      child: const Readable(text: 'Load Receipt'),
    );
  }
}
