import 'package:flutter/material.dart';
import 'package:spending_tracker/widgets/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

int graphIndex = 2;

class HistoData {
  const HistoData(this.y);
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

class ChartView extends StatelessWidget {
  /// Display a graph to the user, allow them to switch between graphs and
  /// choose different x and y values
  final List<StackedData> chartData = const [
    StackedData('China', 12, 10, 14, 20),
    StackedData('USA', 14, 11, 18, 23),
    StackedData('UK', 16, 10, 15, 20),
    StackedData('Brazil', 18, 16, 18, 24)
  ];

  /// Histogram graph
  final List<HistoData> histogramData = const <HistoData>[
    HistoData(5.250),
    HistoData(7.750),
    HistoData(0.0),
    HistoData(8.275),
    HistoData(9.750),
    HistoData(7.750),
    HistoData(8.275),
    HistoData(6.250),
    HistoData(5.750),
    HistoData(5.250),
    HistoData(23.000),
    HistoData(26.500),
    HistoData(26.500),
    HistoData(27.750),
    HistoData(25.025),
    HistoData(26.500),
    HistoData(28.025),
    HistoData(29.250),
    HistoData(26.750),
    HistoData(27.250),
    HistoData(26.250),
    HistoData(25.250),
    HistoData(34.500),
    HistoData(25.625),
    HistoData(25.500),
    HistoData(26.625),
    HistoData(36.275),
    HistoData(36.250),
    HistoData(26.875),
    HistoData(40.000),
    HistoData(43.000),
    HistoData(46.500),
    HistoData(47.750),
    HistoData(45.025),
    HistoData(56.500),
    HistoData(56.500),
    HistoData(58.025),
    HistoData(59.250),
    HistoData(56.750),
    HistoData(57.250),
    HistoData(46.250),
    HistoData(55.250),
    HistoData(44.500),
    HistoData(45.525),
    HistoData(55.500),
    HistoData(46.625),
    HistoData(46.275),
    HistoData(56.250),
    HistoData(46.875),
    HistoData(43.000),
    HistoData(46.250),
    HistoData(55.250),
    HistoData(44.500),
    HistoData(45.425),
    HistoData(55.500),
    HistoData(56.625),
    HistoData(46.275),
    HistoData(56.250),
    HistoData(46.875),
    HistoData(43.000),
    HistoData(46.250),
    HistoData(55.250),
    HistoData(44.500),
    HistoData(45.425),
    HistoData(55.500),
    HistoData(46.625),
    HistoData(56.275),
    HistoData(46.250),
    HistoData(56.875),
    HistoData(41.000),
    HistoData(63.000),
    HistoData(66.500),
    HistoData(67.750),
    HistoData(65.025),
    HistoData(66.500),
    HistoData(76.500),
    HistoData(78.025),
    HistoData(79.250),
    HistoData(76.750),
    HistoData(77.250),
    HistoData(66.250),
    HistoData(75.250),
    HistoData(74.500),
    HistoData(65.625),
    HistoData(75.500),
    HistoData(76.625),
    HistoData(76.275),
    HistoData(66.250),
    HistoData(66.875),
    HistoData(80.000),
    HistoData(85.250),
    HistoData(87.750),
    HistoData(89.000),
    HistoData(88.275),
    HistoData(89.750),
    HistoData(97.750),
    HistoData(98.275),
    HistoData(96.250),
    HistoData(95.750),
    HistoData(95.250)
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

  const ChartView({Key? key}) : super(key: key);

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
          HistogramSeries<HistoData, double>(
              dataSource: histogramData,
              showNormalDistributionCurve: true,
              curveColor: const Color.fromRGBO(192, 108, 132, 1),
              binInterval: 20,
              yValueMapper: (HistoData data, _) => data.y)
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
