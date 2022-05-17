import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spending_tracker/main.dart';
import 'package:spending_tracker/views/receipt_view.dart';

import '../models/receipt.dart';
import '../widgets/widgets.dart';

ValueNotifier<int> currentFilter = ValueNotifier(0);

class ReceiptList extends StatelessWidget {
  const ReceiptList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ValueListenableBuilder(
        valueListenable: GlobalScope.of(context)!.getReceipts(),
        builder: (context, _, __) => Column(
          children: [
            const Center(),

            /// Display all of the users transactions

            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: GlobalScope.of(context)!
                    .getReceipts()
                    .value
                    .asMap()
                    .entries
                    .map<Widget>(
                      (e) => AnimatedBuilder(
                        animation: e.value,
                        builder: ((context, v) {
                          return ReadableTile(receipt: e);
                        }),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReadableTile extends StatelessWidget {
  /// Tile where all text is read when click each part individually
  /// this means that only the part that tapped will be read
  /// each tile will send the user to the receipt's detail page
  ///Tiles have different colors depending on their category type

  const ReadableTile({
    Key? key,
    required this.receipt,
  }) : super(key: key);

  final receipt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        8.0,
      ),
      child: AnimatedBuilder(
        animation: receipt.value,
        builder: (context, child) => child!,
        child: Card(
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Readable.text(receipt.value.store ?? 'Missing Store'),
              subtitle:
                  Readable.text(receipt.value.category ?? 'Missing Category'),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Readable.text(receipt.value.total ?? 'Missing Subtotal'),
                  Readable.text(receipt.value.date ?? 'Missing Date'),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(seconds: 0),
                    pageBuilder: (context, _, __) => ReceiptView(
                      index: receipt.key,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ReceiptsFiltersBar extends StatefulWidget {
  /// This widget is button bar whose buttons filter the current views transactions
  const ReceiptsFiltersBar({
    Key? key,
  }) : super(key: key);

  @override
  State<ReceiptsFiltersBar> createState() => _ReceiptsFiltersBarState();
}

class _ReceiptsFiltersBarState extends State<ReceiptsFiltersBar> {
  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton(
          onPressed: () {
            currentFilter.value = 0;
          },
          child: Readable.text(
            'Last Month',
          ),
        ),
        OutlinedButton(
          onPressed: () {
            currentFilter.value = 1;
          },
          child: Readable.text('Expenses'),
        ),
        OutlinedButton(
          onPressed: () {
            currentFilter.value = 2;
          },
          child: Readable.text('Income'),
        ),
      ],
    );
  }
}

class ReceiptListView extends StatelessWidget {
  const ReceiptListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Readable.text(
              'My Receipts',
            )),
        bottomNavigationBar: CustomNavBar(),
        body: ReceiptList());
  }
}
