import 'package:flutter/material.dart';
import 'package:spending_tracker/main.dart';
import 'package:spending_tracker/views/receipt_list_view.dart';

class ReceiptView extends StatelessWidget {
  const ReceiptView({Key? key, required this.index}) : super(key: key);

  final int index;

  /// Index of current receipt that is being shown
  @override
  Widget build(BuildContext context) {
    var data = GlobalScope.of(context)!.receipts.value;
    data = data[index];
    var storeController = TextEditingController(text: data.store);

    var _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        onChanged: () {
          /// Validate the form, true if valid otherwise false
          if (_formKey.currentState!.validate()) {
            /// Update all the class variables to the correct values
            data.store = storeController.text;
          }
        },
        key: _formKey,
        child: AnimatedBuilder(
          animation: data,
          builder: (context, child) {
            return Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Store Name',
                        border: OutlineInputBorder(),
                      ),
                      controller: storeController,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/receipts');
                  },
                  child: Text('Save'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
