import 'package:flutter/material.dart';
import 'package:spending_tracker/services/storage.dart';
import 'package:spending_tracker/views/receipt_view.dart';

import '../models/receipt.dart';
import '../widgets/widgets.dart';

int currentFilter = 0;

class ReceiptListView extends StatefulWidget {
  /// Show all of the users transaction in spreadsheet like format
  const ReceiptListView({Key? key}) : super(key: key);

  @override
  State<ReceiptListView> createState() => _ReceiptListViewState();
}

class _ReceiptListViewState extends State<ReceiptListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Readable(
          text: 'My Receipts',
        )),
        bottomNavigationBar: const CustomNavBar(),
        body: ReceiptList(r: []));
  }
}

class ReceiptList extends StatelessWidget {
  const ReceiptList({
    Key? key,
    required this.r,
  }) : super(key: key);

  final List r;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Center(
            child: TransactionFiltersBar(),
          ),

          /// Display all of the users transactions

          Expanded(
              child: ListView(
            shrinkWrap: true,
            children: r
                .asMap()
                .entries
                .map<Widget>((e) => ReadableTile(receipt: e.value))
                .toList(),
          ))
        ],
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

  final ReceiptModel receipt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        8.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          border: Border.all(
              width: 5.0,

              /// Change the color of the transaction tile's border depending on
              /// the type transaction this is
              /// ```mermaid
              /// flowChart
              /// Expense --> Red
              /// Income --> Green
              /// ```
              color: receipt.category == 'e' ? Colors.red : Colors.green),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Readable(text: receipt.store ?? 'Missing Store'),
            subtitle: Readable(text: receipt.category ?? 'Missing Category'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Readable(text: receipt.total ?? 'Missing Subtotal'),
                Readable(text: receipt.date ?? 'Missing Date'),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReceiptView(
                    receipt: receipt,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class TransactionFiltersBar extends StatefulWidget {
  /// This widget is button bar whose buttons filter the current views transactions
  const TransactionFiltersBar({
    Key? key,
  }) : super(key: key);

  @override
  State<TransactionFiltersBar> createState() => _TransactionFiltersBarState();
}

class _TransactionFiltersBarState extends State<TransactionFiltersBar> {
  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton(
          onPressed: () {
            setState(() {
              currentFilter = 0;
            });
          },
          child: const Readable(
            text: 'Last Month',
          ),
        ),
        OutlinedButton(
          onPressed: () {
            setState(() {
              currentFilter = 1;
            });
          },
          child: const Readable(text: 'Expenses'),
        ),
        OutlinedButton(
          onPressed: () {
            setState(() {
              currentFilter = 2;
            });
          },
          child: const Readable(text: 'Income'),
        ),
      ],
    );
  }
}
