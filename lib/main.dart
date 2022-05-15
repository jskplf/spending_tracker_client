import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './views/views.dart';
import 'models/receipt.dart';

void main() async {
  /// Create a global list of receipts
  var receipts = ValueNotifier([ReceiptModel(store: 'Demoing')]);
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
    [],
  );
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true; // alway update ui
  }
}
