import 'package:flutter/material.dart';
import 'package:spending_tracker/main.dart';
import 'package:spending_tracker/models/receipt.dart';
import 'package:spending_tracker/widgets/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartsView extends StatelessWidget {
  const ChartsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var receipts = GlobalScope.of(context)!.receipts.value;

    return Scaffold(
      appBar: AppBar(title: Text('My Graph')),
      bottomNavigationBar: const CustomNavBar(),
      body: receipts.length > 0
          ? ColumnGraphWidget()
          : Center(
              child: Text('Error: Please add receipts'),
            ),
    );
  }
}

class ColumnGraphWidget extends StatelessWidget {
  const ColumnGraphWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<ReceiptModel> receipts = GlobalScope.of(context)!.receipts.value;

    print(receipts);
    dynamic chartData = toColumnChart(receipts);
    double max = double.parse(chartData[1].toString());
    double interval = double.parse(chartData[2].toString());
    chartData = chartData[0];

    return chartData.length > 0
        ? SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(
                minimum: 0,
                maximum: max.toDouble(),
                interval: interval.toInt().toDouble()),
            series: <ChartSeries<ColumnCartData, String>>[
              ColumnSeries<ColumnCartData, String>(
                dataSource: chartData as List<ColumnCartData>,
                xValueMapper: (ColumnCartData data, _) => data.x,
                yValueMapper: (ColumnCartData data, _) => data.y,
              )
            ],
          )
        : const Center(
            child:
                Text('Error: You must add receipts before you can view charts'),
          );
  }
}

class ColumnCartData {
  ColumnCartData({required this.x, required this.y});
  final String x;
  final double y;
}

dynamic toColumnChart(List<ReceiptModel> receipts) {
  dynamic names = receipts.map((e) => e.store).toList();
  names = names.toSet();
  var totals = {};
  var max = 0.0;
  names.forEach((name) => totals[name] = 0.0);
  receipts.forEach((element) {
    if (element.store != null) {
      totals[element.store] += double.parse(element.total);
      if (totals[element.store] > max) {
        max = totals[element.store];
      }
    }
  });
  double interval = max / receipts.length;
  List<ColumnCartData> x = [];
  print(totals);
  if (totals[null] != null) {
    return [[], 100, 10];
  }
  totals.forEach((key, value) {
    x.add(ColumnCartData(x: key, y: value));
  });
  return [x, max, interval];
}
