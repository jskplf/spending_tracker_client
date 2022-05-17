import 'dart:convert';

import 'package:flutter/material.dart';
import './views/views.dart';
import 'models/receipt.dart';
import 'package:get_storage/get_storage.dart';

/// Returns a list of receipts that have been stored inside of shared preferences
void main() async {
  /// Create a global list of receipts
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  /// Entry Point of the application
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlobalScope(
      MaterialApp(
        title: 'SpendingTrackerFlutter',
        debugShowCheckedModeBanner: false,
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
  }
}

class GlobalScope extends InheritedWidget {
  GlobalScope(
    child, {
    Key? key,
  }) : super(key: key, child: child);
  static GlobalScope? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<GlobalScope>();
  }

  final ValueNotifier<List<ReceiptModel>> receipts = ValueNotifier(
    GetStorage().read('receipts') == null
        ? []
        : GetStorage()
            .read('receipts')
            .map<ReceiptModel>((e) => ReceiptModel.fromJson(e))
            .toList(),
  );

  ValueNotifier<List<ReceiptModel>> getReceipts() {
    return receipts;
  }

  ReceiptModel getReceipt(int index) {
    if (receipts.value.isNotEmpty && receipts.value.length - 1 >= index) {
      return receipts.value[index];
    }
    throw RangeError('$index : ${receipts.value.length}');
  }

  void saveReceipts() {
    GetStorage()
        .write('receipts', receipts.value.map((e) => e.toJson()).toList());
  }

  get length {
    return receipts.value.length;
  }

  void deleteReceipt(int index) {
    try {
      receipts.value.removeAt(index);
      saveReceipts();
    } catch (e) {
      throw IndexError(
        index,
        receipts.value,
      );
    }
  }

  ValueNotifier<List<ReceiptModel>> getFilteredReceipts() {
    /// Return a list of receipts filtered by the dates that the user has
    /// entered
    return ValueNotifier(receipts.value.where((element) {
      String d = element.date;

      String start = ColumnGraphWidget.startDate.value;
      if (start == "") {
        return true;
      }
      List startSplit = start.split('/');
      List dSplit = d.split('/');
      startSplit = startSplit.map((e) => int.parse(e)).toList();
      dSplit = dSplit.map((e) => int.parse(e)).toList();
      if (dSplit[2] < startSplit[2]) {
        return false;
      } else if (dSplit[1] < startSplit[1]) {
        return false;
      } else if (dSplit[0] < startSplit[0]) {
        return false;
      }

      String end = ColumnGraphWidget.endDate.value;
      List endSplit = end.split('/');
      endSplit = endSplit.map((e) => int.parse(e)).toList();
      if (dSplit[2] > endSplit[2]) {
        return false;
      } else if (dSplit[0] > endSplit[0]) {
        return false;
      } else if (dSplit[1] > endSplit[1]) {
        return false;
      }
      return true;
    }).toList());
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true; // alway update ui
  }

  /// Functions for generating graphs from the current receipts data
  dynamic toCategoryChart() {
    var filtered = getFilteredReceipts().value;
    dynamic names = filtered.map((e) => e.category).toList();
    names = names.toSet();
    if (names.isEmpty) {
      return [[], 100, 10];
    }
    var totals = {};
    var max = 0.0;
    names.forEach((name) => totals[name] = 0.0);
    for (var element in filtered) {
      if (element.category != null) {
        totals[element.category] += double.parse(element.total);
        if (totals[element.category] > max) {
          max = totals[element.category];
        }
      }
    }
    double interval = max / filtered.length;
    List<ColumnCartData> x = [];

    if (totals[null] != null) {
      return [[], 100, 10];
    }
    totals.forEach((key, value) {
      x.add(ColumnCartData(x: key, y: value));
    });
    return [x, max, interval];
  }

  /// Add a new receipt to local storage
  ///
  void addReceipt(ReceiptModel receipt) {
    receipts.value.add(ReceiptModel());
    saveReceipts();
  }

  /// Replace an existing receipt with a new one at the specified index
  /// throws an index error if the receipt list is currently empty
  void editReceipt(int index, ReceiptModel receipt) {
    if (receipts.value.isEmpty) {
      throw IndexError(index, receipts);
    }
    receipts.value[index] = receipt;
    saveReceipts();
  }

  dynamic toStoreChart() {
    var filtered = getFilteredReceipts().value;
    dynamic names = filtered.map((e) => e.store).toList();
    names = names.toSet();
    if (names.isEmpty) {
      return [[], 100, 10];
    }
    var totals = {};
    var max = 0.0;
    names.forEach((name) => totals[name] = 0.0);
    for (var element in filtered) {
      if (element.store != null) {
        totals[element.store] += double.parse(element.total);
        if (totals[element.store] > max) {
          max = totals[element.store];
        }
      }
    }
    double interval = max / filtered.length;
    List<ColumnCartData> x = [];

    if (totals[null] != null) {
      return [[], 100, 10];
    }
    totals.forEach((key, value) {
      x.add(ColumnCartData(x: key, y: value));
    });
    return [x, max, interval];
  }
}
