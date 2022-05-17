import 'package:flutter/material.dart';
import 'package:spending_tracker/main.dart';
import 'package:spending_tracker/models/receipt.dart';
import 'package:spending_tracker/views/views.dart';

class CustomNavBar extends StatelessWidget {
  static ValueNotifier<int> currentScreen = ValueNotifier(1);
  const CustomNavBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentScreen,
      builder: (context, v, c) => BottomNavigationBar(
        onTap: ((value) {
          int pre = currentScreen.value.toInt();
          currentScreen.value = value;
          if (currentScreen.value == pre) {
          } else if (currentScreen.value == 0) {
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(microseconds: 0),
                pageBuilder: (context, _, __) => const ChartsView(),
              ),
            );
          } else if (currentScreen.value == 1) {
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(microseconds: 0),
                pageBuilder: (context, _, __) => const ReceiptListView(),
              ),
            );
          } else if (currentScreen.value == 2) {
            /// Fix THIS
            GlobalScope.of(context)!.receipts.value.add(ReceiptModel());
            Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: Duration(microseconds: 0),
                  pageBuilder: (context, _, __) => ReceiptView(
                    index: GlobalScope.of(context)!.receipts.value.length - 1,
                  ),
                ));
          }
        }),
        currentIndex: currentScreen.value,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_sharp), label: 'My Charts'),
          BottomNavigationBarItem(
              label: 'My Receipts', icon: Icon(Icons.receipt)),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_a_photo), label: 'New Receipt'),
        ],
      ),
    );
  }
}
