import 'package:flutter/material.dart';
import 'package:spending_tracker/models/receipt.dart';
import 'package:spending_tracker/widgets/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartsView extends StatelessWidget {
  const ChartsView({Key? key}) : super(key: key);

  static List<ReceiptModel> receipts = [
    ReceiptModel(store: 'Store 1', total: 100),
    ReceiptModel(store: 'Store 1', total: 100),
    ReceiptModel(store: 'Store 1', total: 100),
    ReceiptModel(store: 'Store 2', total: 15),
    ReceiptModel(store: 'Store 2', total: 15),
    ReceiptModel(store: 'Store 2', total: 15),
    ReceiptModel(store: 'Store 2', total: 15)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: const CustomNavBar(),
      body: ColumnGraphWidget(receipts: receipts),
    );
  }
}

class ColumnGraphWidget extends StatelessWidget {
  const ColumnGraphWidget({
    Key? key,
    required this.receipts,
  }) : super(key: key);

  final List<ReceiptModel> receipts;

  @override
  Widget build(BuildContext context) {
    dynamic chartData = toColumnChart(receipts);
    int max = chartData[1];
    double interval = chartData[2];
    chartData = chartData[0];

    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: max.toDouble(),
          interval: interval.toInt().toDouble()),
      series: <ChartSeries<ColumnCartData, String>>[
        ColumnSeries<ColumnCartData, String>(
          dataSource: chartData,
          xValueMapper: (ColumnCartData data, _) => data.x,
          yValueMapper: (ColumnCartData data, _) => data.y,
        )
      ],
    );
  }
}

class ColumnCartData {
  ColumnCartData({required this.x, required this.y});
  final String x;
  final int y;
}

dynamic toColumnChart(List<ReceiptModel> receipts) {
  dynamic names = receipts.map((e) => e.store).toList();
  names = names.toSet();
  var totals = {};
  var max = 0;
  names.forEach((name) => totals[name] = 0);
  receipts.forEach((element) {
    totals[element.store] += element.total;
    if (totals[element.store] > max) {
      max = totals[element.store];
    }
  });
  double interval = max / receipts.length;
  List<ColumnCartData> x = [];
  totals.forEach((key, value) {
    x.add(ColumnCartData(x: key, y: value));
  });
  return [x, max, interval];
}
