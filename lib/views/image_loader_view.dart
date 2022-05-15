import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:spending_tracker/main.dart';
import 'package:spending_tracker/models/receipt.dart';
import 'package:spending_tracker/services/api.dart';
import 'package:spending_tracker/views/views.dart';

class LoadImageButton extends StatelessWidget {
  /// Opens a native os file picker, uploads the image the user selects to the
  /// OCR server and waits for the results to be sent back. Once the results are
  /// received the app displays the receipt edit form with some fields autofilled
  /// with the ocr results
  const LoadImageButton({
    required this.index,
    Key? key,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.camera_alt),
      onPressed: () async {
        var result = await FilePicker.platform
            .pickFiles(allowMultiple: false, type: FileType.image);

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
                      GlobalScope.of(context)!.editReceipt(index, data);
                      return Center(
                        child: ReceiptView(
                            index: GlobalScope.of(context)!.length - 1),
                      );
                    }
                  }

                  // Displaying LoadingSpinner to indicate waiting state
                  return const Center(
                    child: CircularProgressIndicator(
                      semanticsLabel: 'Loading OCR Results',
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}
