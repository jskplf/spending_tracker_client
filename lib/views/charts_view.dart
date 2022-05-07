import 'package:flutter/material.dart';
import 'package:spending_tracker/widgets/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

/// This screen displays a form that allows the user to input a transaction
/// It should auto fill any information gleaned from using the OCR software
/// on the receipt
class ChartsView extends StatelessWidget {
  const ChartsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Readable(
          text: 'Charts',
        ),
      ),
      bottomNavigationBar: CustomNavBar(),
      body: Column(
        children: [
          SizedBox(
            height: 8.0,
          ),
          GraphChooser(),
          SizedBox(
            height: 10.0,
          ),
          Text('Help'),
        ],
      ),
    );
  }
}

class GraphChooser extends StatefulWidget {
  /// Select which graph should be displayed
  const GraphChooser({
    Key? key,
  }) : super(key: key);

  @override
  State<GraphChooser> createState() => _GraphChooserState();
}

class _GraphChooserState extends State<GraphChooser> {
  int selected = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          OutlinedButton(
            onPressed: () {},
            child: Readable(text: 'Spline Graph'),
          ),
          OutlinedButton(
            onPressed: () {},
            child: Readable(text: 'Stacked Graph'),
          ),
          OutlinedButton(
            onPressed: () {},
            child: Readable(text: 'Range Chart'),
          ),
        ],
      ),
    );
  }
}
