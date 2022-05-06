import 'package:flutter/material.dart';
import 'package:spending_tracker/widgets/widgets.dart';

class ReceiptView extends StatelessWidget {
  /// Display the contents of a scanned receipt
  final dynamic receipt = null;
  const ReceiptView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'View Receipt',
      body: ReceiptFormView(
        receipt: receipt,
      ),
    );
  }
}

class ReceiptFormView extends StatefulWidget {
  /// This widget contains all data that the user has entered about the receipt
  /// it haas fields for the store name, category type, item names and prices,
  /// purchase date, and total amount spent. The user can also link an image
  /// to be linked to the data. The image can also be sent through a post request
  /// to the OCR API server. The server will process the image and return a list
  /// of possible values for each field. Once a receipt has been processed the
  /// form will fill fields in the form with the value. The user will be able to
  /// overwrite any data in the form with data they choose.

  const ReceiptFormView({
    required this.receipt,
    Key? key,
  }) : super(key: key);
  final dynamic receipt;
  @override
  State<ReceiptFormView> createState() => _ReceiptFormViewState();
}

class _ReceiptFormViewState extends State<ReceiptFormView> {
  final _formKey = GlobalKey<FormState>();
  final fields = [
    {'description': 'Store Name', 'initialValue': '', 'validator': (value) {}},
    {'description': 'Address', 'initialValue': '', 'validator': (value) {}},
    {'description': 'Date', 'initialValue': '', 'validator': (value) {}},
    {'description': 'Item', 'initialValue': '', 'validator': (value) {}},
    {'description': 'Item', 'initialValue': '', 'validator': (value) {}},
    {'description': 'Total', 'initialValue': 100.00, 'validator': (value) {}},
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            BaseTextField(field: fields[0]),
            BaseTextField(field: fields[1]),
            BaseTextField(field: fields[2]),
            BaseTextField(field: fields[3]),
            BaseTextField(field: fields[4]),

            /// A widget that places a large amount of white space between
            /// the submit button and the rest of the form
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Readable(text: "Save Receipt"),
            ),
          ],
        ),
      ),
    );
  }
}

class BaseTextField extends StatelessWidget {
  const BaseTextField({
    Key? key,
    required this.field,
  }) : super(key: key);

  final Map<String, Object> field;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: '${field['initialValue']}',
        decoration: InputDecoration(
          hintText: '${field['description']}',
          errorText: "Error Invalid ${field['description']}",
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          return null;
        },
      ),
    );
  }
}
