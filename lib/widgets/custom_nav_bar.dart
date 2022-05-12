import 'package:flutter/material.dart';
import 'package:spending_tracker/views/views.dart';

int _navbarIndex = 1;

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({Key? key}) : super(key: key);

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: ((value) {
        int pre = _navbarIndex;
        if (value == pre) {
        } else if (value == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ChartView(),
            ),
          );
        } else if (value == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ReceiptListView(),
            ),
          );
        } else if (value == 2) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ImageLoaderView(),
            ),
          );
        }
        setState(() {
          _navbarIndex = value;
        });
      }),
      currentIndex: _navbarIndex,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_sharp), label: 'My Charts'),
        BottomNavigationBarItem(
            label: 'My Receipts', icon: Icon(Icons.receipt)),
        BottomNavigationBarItem(
            icon: Icon(Icons.add_a_photo), label: 'New Receipt'),
      ],
    );
  }
}
