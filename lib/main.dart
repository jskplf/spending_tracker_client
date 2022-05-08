import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './views/views.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('receipts');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  /// Entry Point of the application
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpendingTrackerFlutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/transactions',
      routes: {
        /// Start the app at the login screen
        /// The following are all possible screens that the application can
        /// navigate to
        '/transactions': (context) => const TransactionView(),
        '/camera': (context) => const ImageLoaderView(),
        '/receipt': (context) => const ReceiptView(),
        // '/charts'
      },
    );
  }
}
