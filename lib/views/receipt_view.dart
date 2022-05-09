import 'package:flutter/material.dart';
import 'package:spending_tracker/models/receipt.dart';
import 'package:spending_tracker/services/storage.dart';
import 'package:spending_tracker/widgets/widgets.dart';

/// Should be able to insert items in the middle of a list view
/// Total should always be the last item in the list

class ReceiptView extends StatelessWidget {
  /// Display the contents of a scanned receipt
  final dynamic receipt;
  const ReceiptView({Key? key, required this.receipt}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Readable(
          text: 'Receipt Data',
        ),
      ),
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

  @override
  Widget build(BuildContext context) {
    dynamic receipt = widget.receipt;
    print('$receipt');

    /// Generate a form based on these fields
    final fields = [
      {
        'description': 'Store Name',
        'initialValue': receipt.store ?? '',
        'validator': (String? value) {
          if (value!.length > 25) {
            return 'Error: Store name must be less than 25 characters';
          }
          if (value.contains(RegExp(r'[0-9]'))) {
            return 'Error: Store name cannot have any digits';
          }
          return value;
        },
      },
      {
        'description': 'Address',
        'suffix': const Icon(Icons.gps_fixed),
        'initialValue': receipt.address ?? '',
        'validator': (String? value) {
          if (value!.contains(RegExp(r'[A-Za-z0-9\.\s,\-:\n]'))) {
            return value;
          } else {
            if (value.isEmpty) {
              return null;
            } else {
              null;
            }
          }
        },
      },
      {
        'description': 'Date',
        'initialValue': receipt.date ?? '',
        'suffix': const Icon(Icons.calendar_month),
        'validator': (String? value) {
          if (value!.contains(
              RegExp(r'^(0[1-9]|1[0-2])/(0[1-9]|[12][0-9]|3[01])/\d{4}'))) {
            return value;
          } else {
            if (value.isEmpty) {
              return null;
            }
          }
        },
      },
      {
        'description': 'Category',
        'initialValue': receipt.category ?? '',
        'validator': (String? value) {
          if (value!.length < 15) {
            return value;
          }
        },
      },
      {
        'description': 'Total',
        'initialValue': receipt.total ?? '',
        'validator': (String? value) {
          if (double.tryParse(value!) == null) {
            return null;
          }
          return value;
        },
      },
    ];

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children:
                fields.map<Widget>((e) => BaseTextField(field: e)).toList() +
                    [
                      /// A widget that places a large amount of white space between
                      /// the submit button and the rest of the form
                      const SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            saveReceipt(receipt: receipt);
                          }
                        },
                        child: const Readable(text: "Save Receipt"),
                      ),
                    ],
          ),
        ),
      ),
    );
  }
}

class BaseTextField extends StatelessWidget {
  /// text field that displays error message when the validator does not return
  /// a string
  const BaseTextField({
    Key? key,
    required this.field,
  }) : super(key: key);

  final Map<String, Object?> field;

  @override
  Widget build(BuildContext context) {
    var validator = field['validator'];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: '${field['initialValue']}',
        decoration: InputDecoration(
          suffix: field['suffix'] != null ? field['suffix'] as Widget : null,
          hintText: '${field['description']}',
          errorText: "Error Invalid ${field['description']}",
          border: const OutlineInputBorder(),
        ),
        validator: validator as String? Function(String?),
      ),
    );
  }
}
