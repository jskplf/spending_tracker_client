import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:spending_tracker/services/api.dart';
import 'package:spending_tracker/views/views.dart';
import 'package:spending_tracker/widgets/custom_nav_bar.dart';

import '../widgets/readable.dart';

class ImageLoaderView extends StatelessWidget {
  /// This screen allows the user to select an image from their device by
  const ImageLoaderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomNavBar(),
      appBar: AppBar(
        title: const Readable(
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
  /// Opens a native os file picker, uploads the image the user selects to the
  /// OCR server and waits for the results to be sent back. Once the results are
  /// received the app displays the receipt edit form with some fields autofilled
  /// with the ocr results
  const LoadImageButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        FilePickerResult? result = await FilePicker.platform
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
                      return Center(
                        child: ReceiptView(
                          receipt: data,
                        ),
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
      child: const Readable(text: 'Load Receipt'),
    );
  }
}
