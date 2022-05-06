import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

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
    return BaseScaffold(
      title: 'Your Transactions',
      body: Column(
        children: [
          const Center(
            child: TransactionFiltersBar(),
          ),

          /// Display all of the users transactions
          TransactionListView(
            transactions: transactions,
          )
        ],
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

  final transactions;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Scrollbar(
        child: ListView(
          shrinkWrap: true,
          children: [
            ReadableTile(transaction: transactions[0]),
            ReadableTile(transaction: transactions[1]),
            ReadableTile(transaction: transactions[0]),
            ReadableTile(transaction: transactions[1]),
            ReadableTile(transaction: transactions[0]),
            ReadableTile(transaction: transactions[1]),
            ReadableTile(transaction: transactions[0]),
            ReadableTile(transaction: transactions[1]),
            ReadableTile(transaction: transactions[0]),
            ReadableTile(transaction: transactions[1]),
            ReadableTile(transaction: transactions[0]),
            ReadableTile(transaction: transactions[1]),
            ReadableTile(transaction: transactions[0]),
            ReadableTile(transaction: transactions[1]),
            ReadableTile(transaction: transactions[0]),
            ReadableTile(transaction: transactions[1]),
            ReadableTile(transaction: transactions[0]),
            ReadableTile(transaction: transactions[1]),
            ReadableTile(transaction: transactions[0]),
            ReadableTile(transaction: transactions[1]),
          ],
        ),
      ),
    );
  }
}

class ReadableTile extends StatelessWidget {
  const ReadableTile({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  final transaction;

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
    );
  }
}

class TransactionFiltersBar extends StatelessWidget {
  /// This widget is button bar whose buttons filter the current views transactions
  const TransactionFiltersBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton(
          onPressed: () {
            ///TODO filter by previous month
          },
          child: Text(
            'Last Month',
          ),
        ),
        OutlinedButton(
          onPressed: () {
            /// TODO filter by Only Expenses
          },
          child: Text('Expenses'),
        ),
        OutlinedButton(
          onPressed: () {
            /// TODO Filter by Income Only
          },
          child: Text('Income'),
        ),
      ],
    );
  }
}
