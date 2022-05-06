import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class TransactionView extends StatefulWidget {
  /// Show all of the users transaction in spreadsheet like format
  const TransactionView({Key? key}) : super(key: key);

  @override
  State<TransactionView> createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      child: BaseScaffold(
        footer: const [
          ChartsButton(),
          CameraButton(),
        ],
        title: 'Your Transactions',
        body: Column(
          children: const [
            Center(
              child: TransactionFiltersBar(),
            ),

            /// Display all of the users transactions
            TransactionListView()
          ],
        ),
      ),
    );
  }
}

class ChartsButton extends StatelessWidget {
  const ChartsButton({Key? key}) : super(key: key);

  /// A button that when clicked sends the user to the ChartsView Screen

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.compare_arrows),
    );
  }
}

class CameraButton extends StatelessWidget {
  /// A Button that when clicked sends the user to the ImageLoaderScreen
  const CameraButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.camera),
      onPressed: () {
        Navigator.pushNamed(context, '/camera');
      },
    );
  }
}

class TransactionListView extends StatelessWidget {
  /// Displays a list of transactions
  /// These transactions are filterable by Income, Expense and Previous Month
  const TransactionListView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: const [
        ListTile(
          title: Readable(text: 'Transaction 1'),
          subtitle: Readable(text: 'Expense'),
          trailing: Readable(text: "\$100.00"),
        ),
        ListTile(
          title: Readable(text: 'Transaction 1'),
          subtitle: Readable(text: 'Expense'),
          trailing: Readable(text: "\$100.00"),
        ),
        ListTile(
          title: Readable(text: 'Transaction 1'),
          subtitle: Readable(text: 'Expense'),
          trailing: Readable(text: "\$100.00"),
        ),
        ListTile(
          title: Readable(text: 'Transaction 1'),
          subtitle: Readable(text: 'Expense'),
          trailing: Readable(text: "\$100.00"),
        ),
        ListTile(
          title: Readable(text: 'Transaction 1'),
          subtitle: Readable(text: 'Expense'),
          trailing: Readable(text: "\$100.00"),
        ),
        ListTile(
          title: Readable(text: 'Transaction 1'),
          subtitle: Readable(text: 'Expense'),
          trailing: Readable(text: "\$100.00"),
        ),
        ListTile(
          title: Readable(text: 'Transaction 1'),
          subtitle: Readable(text: 'Expense'),
          trailing: Readable(text: "\$100.00"),
        ),
      ],
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
