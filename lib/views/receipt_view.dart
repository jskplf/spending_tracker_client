import 'package:flutter/material.dart';
import 'package:spending_tracker/main.dart';
import 'package:spending_tracker/views/image_loader_view.dart';
import 'package:spending_tracker/widgets/widgets.dart';

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
    var dateController = TextEditingController(text: '${data.date}');
    var totalController = TextEditingController(text: '${data.total}');
    var categoryController = TextEditingController(text: data.category);

    var _formKey = GlobalKey<FormState>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: LoadImageButton(
          index: index,
        ),
        onPressed: () {},
      ),
      bottomNavigationBar: CustomNavBar(),
      appBar: AppBar(
        title: Text('Edit Receipt'),
      ),
      body: Form(
        onChanged: () {},
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
                      validator: (value) {
                        if (value!.length > 25) {
                          return 'Error: Store name must be less than 25 characters';
                        }

                        if (value.isEmpty) {
                          return 'Error: Store name cannot be empty';
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Error: Date can not be empty';
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value!.length > 15) {
                          return 'Error: Category length must be less then 15 characters';
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Error: Total is a required field';
                        }
                        try {
                          double.parse(value);
                        } catch (_) {
                          return 'Error: Total must be a number';
                        }
                        return null;
                      },
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
                        if (_formKey.currentState!.validate()) {
                          data.store = storeController.text;
                          data.address = addressController.text;
                          data.category = categoryController.text;
                          data.date = dateController.text;
                          data.total = totalController.text;
                          Navigator.pushReplacementNamed(context, '/receipts');
                        }
                      },
                      child: Text('Save'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 250, 82, 70)),
                      onPressed: () {
                        GlobalScope.of(context)!.deleteReceipt(index);
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
