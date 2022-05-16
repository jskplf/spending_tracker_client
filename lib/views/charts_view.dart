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
      appBar: AppBar(
        title: const Text('My Graph'),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: const CustomNavBar(),
      body: receipts.isNotEmpty
          ? Column(
              children: [
                DropdownButton(
                    value: ColumnGraphWidget.chartData.value,
                    items: const [
                      DropdownMenuItem(
                        child: Text('Stores'),
                        value: 0,
                      ),
                      DropdownMenuItem(
                        child: Text('Categories'),
                        value: 1,
                      ),
                    ],
                    onChanged: (value) {
                      print(value);
                      ColumnGraphWidget.chartData.value = value;
                      print(ColumnGraphWidget.chartData.value);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChartsView()));
                    }),
                const ColumnGraphWidget(),
              ],
            )
          : const Center(
              child: Text('Error: Please add receipts'),
            ),
    );
  }
}

class ColumnGraphWidget extends StatelessWidget {
  static ValueNotifier chartData = ValueNotifier<int>(0);
  const ColumnGraphWidget({
    Key? key,
  }) : super(key: key);

  factory ColumnGraphWidget.stores(Key? key) {
    return const ColumnGraphWidget();
  }

  @override
  Widget build(BuildContext context) {
    final List<ReceiptModel> receipts = GlobalScope.of(context)!.receipts.value;

    dynamic tempData;
    if (chartData.value == 0) {
      tempData = toStoreChart(receipts);
    } else if (chartData.value == 1) {
      tempData = toCategoryChart(receipts);
    }
    if (tempData == null) {
      return const Center(
        child: Text('Error: Unable to render graph'),
      );
    }
    double max = double.parse(tempData[1].toString());
    double interval = double.parse(tempData[2].toString());
    tempData = tempData[0];

    return tempData.length > 0
        ? ValueListenableBuilder(
            valueListenable: chartData,
            builder: (context, _, __) {
              return SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(
                    minimum: 0,
                    maximum: max.toDouble(),
                    interval: interval.toInt().toDouble()),
                series: <ChartSeries<ColumnCartData, String>>[
                  ColumnSeries<ColumnCartData, String>(
                    dataSource: tempData as List<ColumnCartData>,
                    xValueMapper: (ColumnCartData data, _) => data.x,
                    yValueMapper: (ColumnCartData data, _) => data.y,
                  )
                ],
              );
            })
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

dynamic toCategoryChart(List<ReceiptModel> receipts) {
  dynamic names = receipts.map((e) => e.category).toList();
  names = names.toSet();
  var totals = {};
  var max = 0.0;
  names.forEach((name) => totals[name] = 0.0);
  for (var element in receipts) {
    if (element.category != null) {
      totals[element.category] += double.parse(element.total);
      if (totals[element.category] > max) {
        max = totals[element.category];
      }
    }
  }
  double interval = max / receipts.length;
  List<ColumnCartData> x = [];

  if (totals[null] != null) {
    return [[], 100, 10];
  }
  totals.forEach((key, value) {
    x.add(ColumnCartData(x: key, y: value));
  });
  return [x, max, interval];
}

dynamic toStoreChart(List<ReceiptModel> receipts) {
  dynamic names = receipts.map((e) => e.store).toList();
  names = names.toSet();
  var totals = {};
  var max = 0.0;
  names.forEach((name) => totals[name] = 0.0);
  for (var element in receipts) {
    if (element.store != null) {
      totals[element.store] += double.parse(element.total);
      if (totals[element.store] > max) {
        max = totals[element.store];
      }
    }
  }

  double interval = max / receipts.length;
  List<ColumnCartData> x = [];

  if (totals[null] != null) {
    return [[], 100, 10];
  }
  totals.forEach((key, value) {
    x.add(ColumnCartData(x: key, y: value));
  });
  return [x, max, interval];
}
