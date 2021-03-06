import 'package:flutter/material.dart';
import 'package:spending_tracker/main.dart';
import 'package:spending_tracker/widgets/load_image_button.dart';
import 'package:spending_tracker/views/receipt_list_view.dart';
import 'package:spending_tracker/widgets/widgets.dart';

class ReceiptView extends StatelessWidget {
  const ReceiptView({Key? key, required this.index}) : super(key: key);

  final int index;

  /// Index of current receipt that is being shown
  @override
  Widget build(BuildContext context) {
    dynamic data = GlobalScope.of(context)!.getReceipt(index);
    var storeController = TextEditingController(text: data.store);
    var addressController = TextEditingController(text: data.address);
    var dateController = TextEditingController(text: data.date);
    var totalController = TextEditingController(text: data.total);
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
        automaticallyImplyLeading: false,
        title: Text('Edit Receipt'),
      ),
      body: Form(
        onChanged: () {
          /// Validate the form, true if valid otherwise false
          if (_formKey.currentState!.validate()) {}
        },
        key: _formKey,
        child: AnimatedBuilder(
          animation: data,
          builder: (context, child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  StoreField(storeController),
                  AddressField(addressController: addressController),
                  DateField(dateController: dateController),
                  CategoryField(categoryController: categoryController),
                  TotalField(totalController: totalController),
                  const FormSpacer(),
                  FormFooter(
                      formKey: _formKey,
                      data: data,
                      storeController: storeController,
                      addressController: addressController,
                      categoryController: categoryController,
                      dateController: dateController,
                      totalController: totalController,
                      index: index),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class StoreField extends StatelessWidget {
  const StoreField(
    this.storeController, {
    Key? key,
  }) : super(key: key);

  final TextEditingController storeController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),

        /// For Store Name
        child: TextFormField(
          decoration: const InputDecoration(
            labelText: 'Store Name',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if ((value ?? '') == '') {
              return 'Error: Store is a required field';
            }
            if (value!.length > 25) {
              return 'Error: Store name must be less than 25 characters';
            }
            return null;
          },
          controller: storeController,
        ),
      ),
    );
  }
}

class FormFooter extends StatelessWidget {
  const FormFooter({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.data,
    required this.storeController,
    required this.addressController,
    required this.categoryController,
    required this.dateController,
    required this.totalController,
    required this.index,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final data;
  final TextEditingController storeController;
  final TextEditingController addressController;
  final TextEditingController categoryController;
  final TextEditingController dateController;
  final TextEditingController totalController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SaveReceiptButton(
            formKey: _formKey,
            data: data,
            storeController: storeController,
            addressController: addressController,
            categoryController: categoryController,
            dateController: dateController,
            totalController: totalController),
        DeleteReceiptButton(index: index),
      ],
    );
  }
}

class SaveReceiptButton extends StatelessWidget {
  const SaveReceiptButton({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.data,
    required this.storeController,
    required this.addressController,
    required this.categoryController,
    required this.dateController,
    required this.totalController,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final data;
  final TextEditingController storeController;
  final TextEditingController addressController;
  final TextEditingController categoryController;
  final TextEditingController dateController;
  final TextEditingController totalController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          data.store = storeController.text;
          data.address = addressController.text;
          data.category = categoryController.text;
          data.date = dateController.text;
          data.total = totalController.text;
          GlobalScope.of(context)!.saveReceipts();
          CustomNavBar.currentScreen.value = 1;
          Navigator.push(
              context,
              PageRouteBuilder(
                  transitionDuration: const Duration(seconds: 0),
                  pageBuilder: ((context, animation, secondaryAnimation) =>
                      const ReceiptListView())));
        }
      },
      child: Text('Save'),
    );
  }
}

class DeleteReceiptButton extends StatelessWidget {
  const DeleteReceiptButton({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style:
          ElevatedButton.styleFrom(primary: Color.fromARGB(255, 250, 82, 70)),
      onPressed: () {
        GlobalScope.of(context)!.deleteReceipt(index);
        CustomNavBar.currentScreen.value = 1;
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: const Duration(seconds: 0),
                pageBuilder: ((context, animation, secondaryAnimation) =>
                    const ReceiptListView())));
      },
      child: const Text('Delete'),
    );
  }
}

class FormSpacer extends StatelessWidget {
  const FormSpacer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 15,
    );
  }
}

class TotalField extends StatelessWidget {
  const TotalField({
    Key? key,
    required this.totalController,
  }) : super(key: key);

  final TextEditingController totalController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),

        /// For Date
        child: TextFormField(
          validator: (value) {
            var re = RegExp(r'\d+\. ?\d\d\D?');
            var re2 = RegExp(r'[a-z]*[A-z]');
            if (re2.hasMatch(value!)) {
              return 'Error: Total cannot have any letters';
            } else if (re.hasMatch(value)) {
              if (re.hasMatch(value)) {
                return null;
              }
            } else {
              return 'Error: Invalid value for Total';
            }
          },
          decoration: const InputDecoration(
            labelText: 'Total',
            border: OutlineInputBorder(),
          ),
          controller: totalController,
        ),
      ),
    );
  }
}

class CategoryField extends StatelessWidget {
  const CategoryField({
    Key? key,
    required this.categoryController,
  }) : super(key: key);

  final TextEditingController categoryController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),

        /// For Date
        child: TextFormField(
          decoration: const InputDecoration(
            labelText: 'Category',
            border: OutlineInputBorder(),
          ),
          controller: categoryController,
        ),
      ),
    );
  }
}

class DateField extends StatelessWidget {
  const DateField({
    Key? key,
    required this.dateController,
  }) : super(key: key);

  final TextEditingController dateController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),

        /// For Date
        child: TextFormField(
          validator: (value) {
            var re = RegExp(r'\d{2,2}[-/.]\d{2,2}[-/.]\d{2,4}');
            if (value!.isEmpty) {
              return 'Error: Date cannot be empty';
            }
            if (re.hasMatch(value)) {
              return null;
            } else {
              return 'Error: Invalid date, correct format is 00/00/00 or 00/00/0000';
            }
          },
          decoration: const InputDecoration(
            labelText: 'Date',
            border: OutlineInputBorder(),
          ),
          controller: dateController,
        ),
      ),
    );
  }
}

class AddressField extends StatelessWidget {
  const AddressField({
    Key? key,
    required this.addressController,
  }) : super(key: key);

  final TextEditingController addressController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),

        /// For State and Zip Code
        child: TextFormField(
          validator: (value) {
            var re = RegExp(r'[A-Z]{2} \d{5}');

            if (value != null) {
            } else {
              if (re.hasMatch(value!)) {
                return null;
              } else {
                return 'Error: Invalid State and Zip Code';
              }
            }
            return null;
          },
          decoration: const InputDecoration(
            labelText: 'State and Zip Code',
            border: OutlineInputBorder(),
          ),
          controller: addressController,
        ),
      ),
    );
  }
}
