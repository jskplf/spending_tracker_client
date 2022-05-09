import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:spending_tracker/models/receipt.dart';
import 'package:spending_tracker/services/api.dart';
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
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < 350) {
          return Center(
            child: LoadImageButton(),
          );
        }
        return Row(
          children: [
            LoadImageButton(),
            Expanded(
              child: ReceiptFormView(
                receipt: ReceiptModel.empty(),
              ),
            ),
          ],
        );
      }),
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FutureBuilder(
                future: getOCRResults(result),
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
                      return Center(
                        child: ReceiptView(
                          receipt: data,
                        ),
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
