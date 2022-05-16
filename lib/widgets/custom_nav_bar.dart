import 'package:flutter/material.dart';
import 'package:spending_tracker/main.dart';
import 'package:spending_tracker/models/receipt.dart';
import 'package:spending_tracker/views/views.dart';

ValueNotifier<int> currentScreen = ValueNotifier(1);

class CustomNavBar extends StatelessWidget {
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
              MaterialPageRoute(
                builder: (context) => const ChartsView(),
              ),
            );
          } else if (currentScreen.value == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReceiptListView(),
              ),
            );
          } else if (currentScreen.value == 2) {
            GlobalScope.of(context)!.receipts.value.add(ReceiptModel());

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReceiptView(
                    index: GlobalScope.of(context)!.receipts.value.length - 1),
              ),
            );
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
