import 'package:flutter/material.dart';
import 'package:spending_tracker/widgets/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

int graphIndex = 2;

class ChartData1 {
  const ChartData1(this.y);
  final double y;
}

class SplineData {
  const SplineData(this.x, this.y, this.y1);
  final int x;
  final double y;
  final double y1;
}

class StackedData {
  const StackedData(this.x, this.y1, this.y2, this.y3, this.y4);
  final String x;
  final int y1;
  final int y2;
  final int y3;
  final int y4;
}

/// This screen displays a form that allows the user to input a transaction
/// It should auto fill any information gleaned from using the OCR software
/// on the receipt
class StackedColGraph extends StatelessWidget {
  final List<StackedData> chartData = const [
    StackedData('China', 12, 10, 14, 20),
    StackedData('USA', 14, 11, 18, 23),
    StackedData('UK', 16, 10, 15, 20),
    StackedData('Brazil', 18, 16, 18, 24)
  ];

  final List<ChartData1> histogramData = const <ChartData1>[
    ChartData1(5.250),
    ChartData1(7.750),
    ChartData1(0.0),
    ChartData1(8.275),
    ChartData1(9.750),
    ChartData1(7.750),
    ChartData1(8.275),
    ChartData1(6.250),
    ChartData1(5.750),
    ChartData1(5.250),
    ChartData1(23.000),
    ChartData1(26.500),
    ChartData1(26.500),
    ChartData1(27.750),
    ChartData1(25.025),
    ChartData1(26.500),
    ChartData1(28.025),
    ChartData1(29.250),
    ChartData1(26.750),
    ChartData1(27.250),
    ChartData1(26.250),
    ChartData1(25.250),
    ChartData1(34.500),
    ChartData1(25.625),
    ChartData1(25.500),
    ChartData1(26.625),
    ChartData1(36.275),
    ChartData1(36.250),
    ChartData1(26.875),
    ChartData1(40.000),
    ChartData1(43.000),
    ChartData1(46.500),
    ChartData1(47.750),
    ChartData1(45.025),
    ChartData1(56.500),
    ChartData1(56.500),
    ChartData1(58.025),
    ChartData1(59.250),
    ChartData1(56.750),
    ChartData1(57.250),
    ChartData1(46.250),
    ChartData1(55.250),
    ChartData1(44.500),
    ChartData1(45.525),
    ChartData1(55.500),
    ChartData1(46.625),
    ChartData1(46.275),
    ChartData1(56.250),
    ChartData1(46.875),
    ChartData1(43.000),
    ChartData1(46.250),
    ChartData1(55.250),
    ChartData1(44.500),
    ChartData1(45.425),
    ChartData1(55.500),
    ChartData1(56.625),
    ChartData1(46.275),
    ChartData1(56.250),
    ChartData1(46.875),
    ChartData1(43.000),
    ChartData1(46.250),
    ChartData1(55.250),
    ChartData1(44.500),
    ChartData1(45.425),
    ChartData1(55.500),
    ChartData1(46.625),
    ChartData1(56.275),
    ChartData1(46.250),
    ChartData1(56.875),
    ChartData1(41.000),
    ChartData1(63.000),
    ChartData1(66.500),
    ChartData1(67.750),
    ChartData1(65.025),
    ChartData1(66.500),
    ChartData1(76.500),
    ChartData1(78.025),
    ChartData1(79.250),
    ChartData1(76.750),
    ChartData1(77.250),
    ChartData1(66.250),
    ChartData1(75.250),
    ChartData1(74.500),
    ChartData1(65.625),
    ChartData1(75.500),
    ChartData1(76.625),
    ChartData1(76.275),
    ChartData1(66.250),
    ChartData1(66.875),
    ChartData1(80.000),
    ChartData1(85.250),
    ChartData1(87.750),
    ChartData1(89.000),
    ChartData1(88.275),
    ChartData1(89.750),
    ChartData1(97.750),
    ChartData1(98.275),
    ChartData1(96.250),
    ChartData1(95.750),
    ChartData1(95.250)
  ];

  final List<SplineData> splineData = const <SplineData>[
    SplineData(2010, 10.53, 3.3),
    SplineData(2011, 9.5, 5.4),
    SplineData(2012, 10, 2.65),
    SplineData(2013, 9.4, 2.62),
    SplineData(2014, 5.8, 1.99),
    SplineData(2015, 4.9, 1.44),
    SplineData(2016, 4.5, 2),
    SplineData(2017, 3.6, 1.56),
    SplineData(2018, 3.43, 2.1),
  ];

  const StackedColGraph({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int index = 0;
    final graphs = [
      /// Spline Chart
      SfCartesianChart(
        series: <ChartSeries>[
          SplineAreaSeries<SplineData, int>(
              dataSource: splineData,
              xValueMapper: (SplineData data, _) => data.x,
              yValueMapper: (SplineData data, _) => data.y),
          SplineAreaSeries<SplineData, int>(
              dataSource: splineData,
              xValueMapper: (SplineData data, _) => data.x,
              yValueMapper: (SplineData data, _) => data.y1),
        ],
      ),

      /// Stacked Column Chart
      SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <ChartSeries>[
          StackedColumnSeries<StackedData, String>(
              dataSource: chartData,
              xValueMapper: (StackedData data, _) => data.x,
              yValueMapper: (StackedData data, _) => data.y1),
          StackedColumnSeries<StackedData, String>(
              dataSource: chartData,
              xValueMapper: (StackedData data, _) => data.x,
              yValueMapper: (StackedData data, _) => data.y2),
          StackedColumnSeries<StackedData, String>(
              dataSource: chartData,
              xValueMapper: (StackedData data, _) => data.x,
              yValueMapper: (StackedData data, _) => data.y3),
          StackedColumnSeries<StackedData, String>(
              dataSource: chartData,
              xValueMapper: (StackedData data, _) => data.x,
              yValueMapper: (StackedData data, _) => data.y4)
        ],
      ),

      /// Histogram Chart
      SfCartesianChart(
        series: <ChartSeries>[
          HistogramSeries<ChartData1, double>(
              dataSource: histogramData,
              showNormalDistributionCurve: true,
              curveColor: const Color.fromRGBO(192, 108, 132, 1),
              binInterval: 20,
              yValueMapper: (ChartData1 data, _) => data.y)
        ],
      ),
    ];
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
          graphs[graphIndex],
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
            onPressed: () {
              setState(() {
                graphIndex = 0;
              });
            },
            child: Readable(text: 'Spline Graph'),
          ),
          OutlinedButton(
            onPressed: () {
              setState(() {
                graphIndex = 1;
              });
            },
            child: Readable(text: 'Stacked Graph'),
          ),
          OutlinedButton(
            onPressed: () {
              setState(() {
                graphIndex = 2;
              });
            },
            child: Readable(text: 'Range Chart'),
          ),
        ],
      ),
    );
  }
}
