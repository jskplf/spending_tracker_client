import 'package:flutter/material.dart';
import 'package:spending_tracker/views/views.dart';

class CustomNavBar extends StatefulWidget {
  const CustomNavBar({Key? key}) : super(key: key);

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int _index = 1; // index of current window

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: ((value) {
        int pre = _index;
        setState(() {
          _index = value;
          if (value == pre) {
          } else if (value == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const StackedColGraph(),
              ),
            );
          } else if (value == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TransactionView(),
              ),
            );
          } else if (value == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ImageLoaderView(),
              ),
            );
          }
        });
      }),
      currentIndex: _index,
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
