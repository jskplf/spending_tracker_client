import 'package:flutter/material.dart';

import 'widgets.dart';

class BaseScaffold extends StatefulWidget {
  /// This is the scaffold that all screens of the application use
  /// This ensures that all Screens are fully interactive. This means that
  /// users will be able to magnify any part of the application
  /// TODO figure out a quick way to take users out of zoom mode
  const BaseScaffold({
    required this.title,
    required this.body,
    this.footer,
    Key? key,
  }) : super(key: key);

  final String title;
  final Widget body;
  final List<Widget>? footer;

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  @override
  Widget build(BuildContext context) {
    int _index = 1; // Start on The transaction screen
    return Scaffold(
      appBar: AppBar(
        title: Readable(text: widget.title),
      ),
      body: InteractiveViewer(child: widget.body),
      bottomNavigationBar: BottomNavigationBar(
        onTap: ((value) {
          int p = _index;

          setState(() {
            _index = value;
          });

          if (value == 0) {
            /// TODO Go to chart screen
            // Navigator.pushNamed(context, routeName)

          } else if (value == 1) {
            setState(() {
              _index = value;
            });
            Navigator.pushNamed(context, '/transactions');
          } else if (value == 2) {
            setState(() {
              _index = value;
            });
            Navigator.pushNamed(context, '/camera');
          }
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
      ),
    );
  }
}
