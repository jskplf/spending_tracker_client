import 'package:flutter/material.dart';
import 'package:spending_tracker/services/storage.dart';

import '../widgets/widgets.dart';

int currentFilter = 0;

class TransactionView extends StatefulWidget {
  /// Show all of the users transaction in spreadsheet like format
  const TransactionView({Key? key}) : super(key: key);

  @override
  State<TransactionView> createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  final List transactions = [
    {
      'id': 0,
      'description': 'Receipt 1',
      'transaction_category': 'Income',
      'amount': '\$100.00',
      'date': '01/01/1000',
      'items': [
        {
          'name': 'Sandwich',
          'amount': 2.50,
        }
      ],
    },
    {
      'id': 1,
      'description': 'Receipt 2',
      'transaction_category': 'Expense',
      'amount': '\$100.00',
      'date': '01/01/1000',
      'items': [
        {
          'name': 'Sandwich',
          'amount': 2.50,
        }
      ],
    },
  ];
  @override
  Widget build(BuildContext context) {
    List<dynamic> t = [];

    /// a subset of the users transactions
    if (currentFilter == 0) {
      t = transactions;
    } else if (currentFilter == 1) {
      t = transactions
          .where((element) => element['transaction_category'] == "Expense")
          .toList();
    } else if (currentFilter == 2) {
      t = transactions
          .where((element) => element['transaction_category'] == "Income")
          .toList();
    }
    return Scaffold(
      appBar: AppBar(
          title: const Readable(
        text: 'Past Transactions',
      )),
      bottomNavigationBar: const CustomNavBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Center(
              child: TransactionFiltersBar(),
            ),

            /// Display all of the users transactions
            Text(
              getReceipts().toString(),
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionListView extends StatelessWidget {
  /// Displays a list of transactions
  /// These transactions are filterable by Income, Expense and Previous Month
  /// When a tile is clicked the user is taken to an edit screen for that receipt

  const TransactionListView({
    required this.transactions,
    Key? key,
  }) : super(key: key);

  final List<dynamic> transactions;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: transactions
            .map<Widget>((e) => ReadableTile(transaction: e))
            .toList(),
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
    required this.transaction,
  }) : super(key: key);

  final dynamic transaction;

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
              color: transaction['transaction_category'] == 'Expense'
                  ? Colors.red
                  : Colors.green),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Readable(text: transaction['description']!),
            subtitle: Readable(text: transaction['transaction_category']!),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Readable(text: transaction['amount']!),
                Readable(text: transaction['date']!)
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, '/receipt', arguments: transaction);
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
