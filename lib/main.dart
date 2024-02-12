import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphic_chart/models/tournee.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

void main() {
  return runApp(_ChartApp());
}

class _ChartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: false),
      home: _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  _MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  List<Tournee> tours = [];
  List dataJson = [];
  Future<void> loadJson() async {
    String jsonString = await rootBundle.loadString('assets/data.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);
    print('JSON DATA: $jsonData');
    List<dynamic> tournees = jsonData['tours'];
    print('tournees DATA: $tournees');
    tours = tournees.map((tournee) => Tournee.fromJson(tournee)).toList();
  }

  bool isLoaded = false;
  List<_SalesData> data = [
    _SalesData('Jan', 35),
    _SalesData('Feb', 28),
    _SalesData('Mar', 34),
    _SalesData('Apr', 32),
    _SalesData('May', 40)
  ];
  @override
  void initState() {
    loadJson().then((value) {
      setState(() {
        isLoaded = true;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  String selectedInterval = 'Mois';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Syncfusion Flutter chart'),
        ),
        body: isLoaded
            ? Column(children: [
                //Initialize the chart widget
                Expanded(
                  child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      // Chart title
                      title: ChartTitle(text: ''),
                      // Enable legend
                      legend: Legend(isVisible: true),
                      // Enable tooltip
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <CartesianSeries<Tournee, String>>[
                        LineSeries<Tournee, String>(
                            dataSource: tours,
                            xValueMapper: (Tournee tour, _) => tour.mois,
                            yValueMapper: (Tournee tour, _) => tour.realises,
                            yAxisName: "y",
                            // Enable data label
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true))
                      ]),
                ),
              ])
            : CircularProgressIndicator());
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
