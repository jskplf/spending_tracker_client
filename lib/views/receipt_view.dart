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
    var addressController = TextEditingController(text: data.address);
    var dateController = TextEditingController(text: data.date);
    var totalController = TextEditingController(text: data.total);
    var categoryController = TextEditingController(text: data.category);

    var _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        onChanged: () {
          /// Validate the form, true if valid otherwise false
          if (_formKey.currentState!.validate()) {
            /// Update all the class variables to the correct values
            data.store = storeController.text;
            data.address = addressController.text;
            data.category = categoryController.text;
            data.date = dateController.text;
            data.total = totalController.text;
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

                    /// For Store Name
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Store Name',
                        border: OutlineInputBorder(),
                      ),
                      controller: storeController,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),

                    /// For State and Zip Code
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'State and Zip Code',
                        border: OutlineInputBorder(),
                      ),
                      controller: addressController,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),

                    /// For Date
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Date',
                        border: OutlineInputBorder(),
                      ),
                      controller: dateController,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),

                    /// For Date
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(),
                      ),
                      controller: categoryController,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),

                    /// For Date
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Total',
                        border: OutlineInputBorder(),
                      ),
                      controller: totalController,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/receipts');
                      },
                      child: Text('Save'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 250, 82, 70)),
                      onPressed: () {
                        GlobalScope.of(context)!.receipts.value.removeAt(index);
                        Navigator.pushReplacementNamed(context, '/receipts');
                      },
                      child: Text('Delete'),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
