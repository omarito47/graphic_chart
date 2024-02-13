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
  List<TourneeDate> dates = [];
  List monthsNames = [];
  List dataJson = [];
  List<int> listAnne = [];
  List<Map<String, dynamic>> anneeTotal = [];
  int totalParAnne1 = 0;
  int totalParAnne2 = 0;

  Future<void> loadJson() async {
    String jsonString = await rootBundle.loadString('assets/data.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);
    print('JSON DATA: $jsonData');
    List<dynamic> tournees = jsonData['tours'];
    print('tournees DATA: $tournees');
    tours = tournees.map((tournee) => Tournee.fromJson(tournee)).toList();
    var pos = 0;
    for (var i = 0; i < tours[0].months.length; i++) {
      totalParAnne1 += tours[0].months[i].realises!;
      setState(() {
        pos = i;
      });
    }

    print(totalParAnne1);
    print(totalParAnne2);
    // totalParAnnee.add(totalParAnne1);
    // totalParAnnee.add(totalParAnne2);
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

  String selectedPeriod = 'jour';
  bool isNotbtn1Selected = false;
  bool isNotbtn2Selected = true;
  bool isNotbtn3Selected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoaded
            ? SingleChildScrollView(
                child: Column(children: [
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: isNotbtn1Selected
                            ? () {
                                setState(() {
                                  selectedPeriod = 'jour';
                                  isNotbtn1Selected = false;
                                  isNotbtn2Selected = true;
                                  isNotbtn3Selected = true;
                                });
                              }
                            : null,
                        child: Text('Jour'),
                      ),
                      SizedBox(width: 16.0),
                      ElevatedButton(
                        onPressed: isNotbtn2Selected
                            ? () {
                                setState(() {
                                  selectedPeriod = 'mois';
                                  isNotbtn1Selected = true;
                                  isNotbtn2Selected = false;
                                  isNotbtn3Selected = true;
                                });
                              }
                            : null,
                        child: Text('Mois'),
                      ),
                      SizedBox(width: 16.0),
                      ElevatedButton(
                        onPressed: isNotbtn3Selected
                            ? () {
                                setState(() {
                                  selectedPeriod = 'annee';
                                  isNotbtn1Selected = true;
                                  isNotbtn2Selected = true;
                                  isNotbtn3Selected = false;
                                });
                              }
                            : null,
                        child: Text('Année'),
                      ),
                    ],
                  ),
                  //Initialize the chart widget
                  if (selectedPeriod == "jour")
                    Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .8,
                          width: MediaQuery.of(context).size.width,
                          child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            // Chart title
                            title: ChartTitle(text: '${tours[0].annee}'),
                            // Enable legend
                            legend: Legend(isVisible: true),
                            enableAxisAnimation: true,

                            // Enable tooltip
                            tooltipBehavior: TooltipBehavior(enable: true),
                            series: <CartesianSeries<TourneeDate, String>>[
                              LineSeries<TourneeDate, String>(
                                  color: Colors.amber,
                                  dataSource: tours[0].months[0].dates,
                                  xValueMapper: (TourneeDate listDates, _) =>
                                      listDates.jour.toString(),
                                  yValueMapper: (TourneeDate listDates, _) =>
                                      listDates.realises,
                                  name: "Janvier",
                                  animationDelay: 3.0,
                                  // Enable data label
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true)),
                              LineSeries<TourneeDate, String>(
                                  color: Colors.blue,
                                  dataSource: tours[0].months[1].dates,
                                  xValueMapper: (TourneeDate listDates, _) =>
                                      listDates.jour.toString(),
                                  yValueMapper: (TourneeDate listDates, _) =>
                                      listDates.realises,
                                  name: "Fevrier",
                                  animationDelay: 3.0,
                                  // Enable data label
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true)),
                              LineSeries<TourneeDate, String>(
                                  color: Colors.red,
                                  dataSource: tours[0].months[2].dates,
                                  xValueMapper: (TourneeDate listDates, _) =>
                                      listDates.jour.toString(),
                                  yValueMapper: (TourneeDate listDates, _) =>
                                      listDates.realises,
                                  name: "Mars",
                                  animationDelay: 3.0,

                                  // Enable data label
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true)),
                              LineSeries<TourneeDate, String>(
                                  color: Colors.black,
                                  dataSource: tours[0].months[3].dates,
                                  xValueMapper: (TourneeDate listDates, _) =>
                                      listDates.jour.toString(),
                                  yValueMapper: (TourneeDate listDates, _) =>
                                      listDates.realises,
                                  name: "Avril",
                                  animationDelay: 3.0,
                                  // Enable data label
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true)),
                              LineSeries<TourneeDate, String>(
                                  color: Colors.green,
                                  dataSource: tours[0].months[4].dates,
                                  xValueMapper: (TourneeDate listDates, _) =>
                                      listDates.jour.toString(),
                                  yValueMapper: (TourneeDate listDates, _) =>
                                      listDates.realises,
                                  name: "Mai",
                                  animationDelay: 3.0,
                                  // Enable data label
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true)),
                              LineSeries<TourneeDate, String>(
                                  color: Colors.purple,
                                  dataSource: tours[0].months[5].dates,
                                  xValueMapper: (TourneeDate listDates, _) =>
                                      listDates.jour.toString(),
                                  yValueMapper: (TourneeDate listDates, _) =>
                                      listDates.realises,
                                  name: "Juin",
                                  animationDelay: 3.0,
                                  // Enable data label
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true)),
                              LineSeries<TourneeDate, String>(
                                  color: Colors.orange,
                                  dataSource: tours[0].months[6].dates,
                                  xValueMapper: (TourneeDate listDates, _) =>
                                      listDates.jour.toString(),
                                  yValueMapper: (TourneeDate listDates, _) =>
                                      listDates.realises,
                                  name: "Juiliet",
                                  animationDelay: 3.0,
                                  // Enable data label
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true)),
                              LineSeries<TourneeDate, String>(
                                  color: const Color.fromARGB(255, 0, 229, 255),
                                  dataSource: tours[0].months[7].dates,
                                  xValueMapper: (TourneeDate listDates, _) =>
                                      listDates.jour.toString(),
                                  yValueMapper: (TourneeDate listDates, _) =>
                                      listDates.realises,
                                  name: "Août",
                                  animationDelay: 3.0,
                                  // Enable data label
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true)),
                              LineSeries<TourneeDate, String>(
                                  color: const Color.fromARGB(255, 255, 0, 238),
                                  dataSource: tours[0].months[8].dates,
                                  xValueMapper: (TourneeDate listDates, _) =>
                                      listDates.jour.toString(),
                                  yValueMapper: (TourneeDate listDates, _) =>
                                      listDates.realises,
                                  name: "September",
                                  animationDelay: 3.0,
                                  // Enable data label
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true)),
                              LineSeries<TourneeDate, String>(
                                  color: Color.fromARGB(255, 0, 255, 21),
                                  dataSource: tours[0].months[9].dates,
                                  xValueMapper: (TourneeDate listDates, _) =>
                                      listDates.jour.toString(),
                                  yValueMapper: (TourneeDate listDates, _) =>
                                      listDates.realises,
                                  name: "October",
                                  animationDelay: 3.0,
                                  // Enable data label
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true)),
                              LineSeries<TourneeDate, String>(
                                  color: Color.fromARGB(255, 47, 0, 255),
                                  dataSource: tours[0].months[10].dates,
                                  xValueMapper: (TourneeDate listDates, _) =>
                                      listDates.jour.toString(),
                                  yValueMapper: (TourneeDate listDates, _) =>
                                      listDates.realises,
                                  name: "November",
                                  animationDelay: 3.0,
                                  // Enable data label
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true)),
                              LineSeries<TourneeDate, String>(
                                  color: Color.fromARGB(255, 179, 255, 0),
                                  dataSource: tours[0].months[11].dates,
                                  xValueMapper: (TourneeDate listDates, _) =>
                                      listDates.jour.toString(),
                                  yValueMapper: (TourneeDate listDates, _) =>
                                      listDates.realises,
                                  name: "December",
                                  animationDelay: 3.0,
                                  // Enable data label
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true))
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * .8,
                          width: MediaQuery.of(context).size.width,
                          child: SfCartesianChart(
                            primaryXAxis: CategoryAxis(),
                            // Chart title
                            title: ChartTitle(text: '${tours[1].annee}'),
                            // Enable legend
                            legend: Legend(isVisible: true),
                            enableAxisAnimation: true,

                            // Enable tooltip
                            tooltipBehavior: TooltipBehavior(enable: true),
                            series: <CartesianSeries<TourneeDate, String>>[
                              LineSeries<TourneeDate, String>(
                                  color: Colors.amber,
                                  dataSource: tours[1].months[0].dates,
                                  xValueMapper: (TourneeDate listDates, _) =>
                                      listDates.jour.toString(),
                                  yValueMapper: (TourneeDate listDates, _) =>
                                      listDates.realises,
                                  name: "Janvier",
                                  animationDelay: 3.0,
                                  // Enable data label
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true)),
                              LineSeries<TourneeDate, String>(
                                  color: Colors.blue,
                                  dataSource: tours[1].months[1].dates,
                                  xValueMapper: (TourneeDate listDates, _) =>
                                      listDates.jour.toString(),
                                  yValueMapper: (TourneeDate listDates, _) =>
                                      listDates.realises,
                                  name: "Fevrier",
                                  animationDelay: 3.0,
                                  // Enable data label
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true)),
                              LineSeries<TourneeDate, String>(
                                  color: Colors.red,
                                  dataSource: tours[1].months[2].dates,
                                  xValueMapper: (TourneeDate listDates, _) =>
                                      listDates.jour.toString(),
                                  yValueMapper: (TourneeDate listDates, _) =>
                                      listDates.realises,
                                  name: "Mars",
                                  animationDelay: 3.0,
                                  // Enable data label
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true)),
                              LineSeries<TourneeDate, String>(
                                  color: Colors.black,
                                  dataSource: tours[1].months[3].dates,
                                  xValueMapper: (TourneeDate listDates, _) =>
                                      listDates.jour.toString(),
                                  yValueMapper: (TourneeDate listDates, _) =>
                                      listDates.realises,
                                  name: "Avril",
                                  animationDelay: 3.0,
                                  // Enable data label
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true)),
                              LineSeries<TourneeDate, String>(
                                  color: Colors.green,
                                  dataSource: tours[1].months[4].dates,
                                  xValueMapper: (TourneeDate listDates, _) =>
                                      listDates.jour.toString(),
                                  yValueMapper: (TourneeDate listDates, _) =>
                                      listDates.realises,
                                  name: "Mai",
                                  animationDelay: 3.0,
                                  // Enable data label
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true)),
                              LineSeries<TourneeDate, String>(
                                  color: Colors.purple,
                                  dataSource: tours[1].months[5].dates,
                                  xValueMapper: (TourneeDate listDates, _) =>
                                      listDates.jour.toString(),
                                  yValueMapper: (TourneeDate listDates, _) =>
                                      listDates.realises,
                                  name: "Juin",
                                  animationDelay: 3.0,
                                  // Enable data label
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true)),
                              LineSeries<TourneeDate, String>(
                                  color: Colors.orange,
                                  dataSource: tours[1].months[6].dates,
                                  xValueMapper: (TourneeDate listDates, _) =>
                                      listDates.jour.toString(),
                                  yValueMapper: (TourneeDate listDates, _) =>
                                      listDates.realises,
                                  name: "Juiliet",
                                  animationDelay: 3.0,
                                  // Enable data label
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true)),
                              LineSeries<TourneeDate, String>(
                                  color: const Color.fromARGB(255, 0, 229, 255),
                                  dataSource: tours[1].months[7].dates,
                                  xValueMapper: (TourneeDate listDates, _) =>
                                      listDates.jour.toString(),
                                  yValueMapper: (TourneeDate listDates, _) =>
                                      listDates.realises,
                                  name: "Août",
                                  animationDelay: 3.0,
                                  // Enable data label
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true)),
                              LineSeries<TourneeDate, String>(
                                  color: const Color.fromARGB(255, 255, 0, 238),
                                  dataSource: tours[1].months[8].dates,
                                  xValueMapper: (TourneeDate listDates, _) =>
                                      listDates.jour.toString(),
                                  yValueMapper: (TourneeDate listDates, _) =>
                                      listDates.realises,
                                  name: "September",
                                  animationDelay: 3.0,
                                  // Enable data label
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true)),
                              LineSeries<TourneeDate, String>(
                                  color: Color.fromARGB(255, 0, 255, 21),
                                  dataSource: tours[1].months[9].dates,
                                  xValueMapper: (TourneeDate listDates, _) =>
                                      listDates.jour.toString(),
                                  yValueMapper: (TourneeDate listDates, _) =>
                                      listDates.realises,
                                  name: "October",
                                  animationDelay: 3.0,
                                  // Enable data label
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true)),
                              LineSeries<TourneeDate, String>(
                                  color: Color.fromARGB(255, 47, 0, 255),
                                  dataSource: tours[1].months[10].dates,
                                  xValueMapper: (TourneeDate listDates, _) =>
                                      listDates.jour.toString(),
                                  yValueMapper: (TourneeDate listDates, _) =>
                                      listDates.realises,
                                  name: "November",
                                  animationDelay: 3.0,
                                  // Enable data label
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true)),
                              LineSeries<TourneeDate, String>(
                                  color: Color.fromARGB(255, 179, 255, 0),
                                  dataSource: tours[1].months[11].dates,
                                  xValueMapper: (TourneeDate listDates, _) =>
                                      listDates.jour.toString(),
                                  yValueMapper: (TourneeDate listDates, _) =>
                                      listDates.realises,
                                  name: "December",
                                  animationDelay: 3.0,
                                  // Enable data label
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true))
                            ],
                          ),
                        ),
                      ],
                    ),
                  if (selectedPeriod == "mois")
                    Container(
                      height: MediaQuery.of(context).size.height * .8,
                      width: MediaQuery.of(context).size.width * .99,
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        // Chart title
                        title: ChartTitle(text: ''),
                        // Enable legend
                        legend: Legend(isVisible: true),
                        enableAxisAnimation: true,

                        // Enable tooltip
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <CartesianSeries<MonthData, String>>[
                          LineSeries<MonthData, String>(
                              color: Colors.amber,
                              dataSource: tours[0].months,
                              xValueMapper: (MonthData monthData, _) =>
                                  monthData.mois,
                              yValueMapper: (MonthData monthData, _) =>
                                  monthData.realises,
                              name: "${tours[0].annee}",
                              animationDelay: 3.0,
                              // Enable data label
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true)),
                          LineSeries<MonthData, String>(
                              color: Colors.blue,
                              dataSource: tours[1].months,
                              xValueMapper: (MonthData monthData, _) =>
                                  monthData.mois,
                              yValueMapper: (MonthData monthData, _) =>
                                  monthData.realises,
                              name: "${tours[1].annee}",
                              animationDelay: 3.0,
                              // Enable data label
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true)),
                        ],
                      ),
                    ),
                  if (selectedPeriod == "annee")
                    Builder(
                      builder: (context) {
                        return Container(
                          height: MediaQuery.of(context).size.height * .8,
                          width: MediaQuery.of(context).size.width,
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
                                  color: Colors.amber,
                                  dataSource: tours,
                                  xValueMapper: (Tournee tour, _) =>
                                      tour.annee.toString(),
                                  yValueMapper: (Tournee tour, _) {
                                    return tour.realises;
                                  },
                                  name: "nombre de tournées réalisées",
                                  animationDelay: 3.0,
                                  // Enable data label
                                  dataLabelSettings:
                                      DataLabelSettings(isVisible: true)),
                            ],
                          ),
                        );
                      }
                    ),
                ]),
              )
            : CircularProgressIndicator());
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
