import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:spending_tracker/widgets/base_scaffold.dart';
import 'package:http/http.dart' as http;

import '../widgets/readable.dart';

class ImageLoaderView extends StatelessWidget {
  /// This screen allows the user to select an image from their device by
  const ImageLoaderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      /// Allow the user to manually enter their transaction
      /// TODO carry over data gained from ocr in the app
      footer: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, '/addTransaction');
          },
        ),
      ],
      title: 'Load Image',
      body: LoadImageButton(),
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
        FilePickerResult? result =
            await FilePicker.platform.pickFiles(type: FileType.image);
        if (result != null) {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: InteractiveViewer(
                      child: Image.memory(result.files.single.bytes!)),
                );
              });
          final file = result.files.single;

          /// Use ocr api to find out get some auto fill suggestions
          var request = http.MultipartRequest(
              'POST', Uri.parse('http://localhost:8000/ocr/'));

          var response = await request.send();
        }
      },
      child: const Readable(text: 'Load Receipt'),
    );
  }
}
