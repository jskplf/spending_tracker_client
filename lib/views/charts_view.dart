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

    try {
      return Scaffold(
          appBar: AppBar(title: Text('My Graph')),
          bottomNavigationBar: const CustomNavBar(),
          body: ColumnGraphWidget(
            receipts: receipts,
          ));
    } catch (e) {
      return Scaffold(
        appBar: AppBar(
          title: Text('My Graph'),
        ),
        body: Text('UNable to display graphs at this time'),
      );
    }
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
    double max = chartData[1];
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
  if (totals == null) {
    return [];
  }
  if (totals == {}) return [[], 100, 10];
  totals.forEach((key, value) {
    x.add(ColumnCartData(x: key, y: value));
  });
  return [x, max, interval];
}
