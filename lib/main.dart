import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './views/views.dart';
import 'models/receipt.dart';

dynamic loadReceipts() async {
  /// Returns a list of receipts that have been stored inside of shared preferences
  var prefs = await SharedPreferences.getInstance();
  var receipts = ValueNotifier(prefs.get('receipts') ?? []);
  print(receipts);
  return receipts;
}

void main() async {
  /// Create a global list of receipts
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  /// Entry Point of the application
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadReceipts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GlobalScope(
              snapshot.data,
              MaterialApp(
                title: 'SpendingTrackerFlutter',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                initialRoute: '/receipts',
                routes: {
                  /// Start the app at the login screen
                  /// The following are all possible screens that the application can
                  /// navigate to
                  '/receipts': (context) => ReceiptListView(),
                  // '/charts'
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}

class GlobalScope extends InheritedWidget {
  GlobalScope(
    this.receipts,
    child, {
    Key? key,
  }) : super(key: key, child: child);
  static GlobalScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GlobalScope>();
  }

  final receipts;
  final ValueNotifier _receipts = ValueNotifier(GlobalScope);

  void addReceipt(ReceiptModel n) async {
    _receipts.value.add(n);
    saveReceipts();
  }

  ReceiptModel getReceipt(index) {
    try {
      return _receipts.value[index];
    } catch (e) {
      throw IndexError(index, _receipts.value);
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true; // alway update ui
  }

  void saveReceipts() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
        'receipts', _receipts.value.map((e) => jsonEncode(e)));
  }

  void editReceipt(int index, ReceiptModel n) async {
    _receipts.value[index] = n;
    saveReceipts();
  }

  /// Update shared prefrences

  get length {
    return _receipts.value.length;
  }

  void deleteReceipt(int index) {
    _receipts.value.removeAt(index);
    saveReceipts();
  }
}
