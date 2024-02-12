import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bar Chart Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<TourneeData> tournees = [
    TourneeData(
      mois: 'Mars',
      annee: 2023,
      realises: 25,
      date: [
        DayData(jour: 12, realises: 1),
        DayData(jour: 17, realises: 3),
        DayData(jour: 25, realises: 2),
      ],
    ),
    TourneeData(
      mois: 'Avril',
      annee: 2023,
      realises: 18,
      date: [
        DayData(jour: 5, realises: 2),
        DayData(jour: 14, realises: 1),
        DayData(jour: 23, realises: 3),
      ],
    ),
    TourneeData(
      mois: 'Mai',
      annee: 2023,
      realises: 30,
      date: [
        DayData(jour: 2, realises: 4),
        DayData(jour: 10, realises: 2),
        DayData(jour: 19, realises: 3),
      ],
    ),
    TourneeData(
      mois: 'Juin',
      annee: 2023,
      realises: 22,
      date: [
        DayData(jour: 7, realises: 1),
        DayData(jour: 16, realises: 2),
        DayData(jour: 28, realises: 3),
      ],
    ),
    TourneeData(
      mois: 'Juillet',
      annee: 2023,
      realises: 27,
      date: [
        DayData(jour: 4, realises: 2),
        DayData(jour: 13, realises: 3),
        DayData(jour: 21, realises: 1),
      ],
    ),
    TourneeData(
      mois: 'Août',
      annee: 2023,
      realises: 20,
      date: [
        DayData(jour: 8, realises: 1),
        DayData(jour: 16, realises: 2),
        DayData(jour: 25, realises: 1),
      ],
    ),
    TourneeData(
      mois: 'Septembre',
      annee: 2023,
      realises: 23,
      date: [
        DayData(jour: 2, realises: 2),
        DayData(jour: 10, realises: 3),
        DayData(jour: 19, realises: 1),
      ],
    ),
  ];

  String selectedInterval = 'Mois';

  void changeInterval(String interval) {
    setState(() {
      selectedInterval = interval;
    });
  }

  List<charts.Series<IntervalData, String>> _createChartData() {
    List<IntervalData> data = [];

    if (selectedInterval == 'Mois') {
      for (var tournee in tournees) {
        data.add(IntervalData(
          interval: tournee.mois,
          count: tournee.realises,
        ));
      }
    } else if (selectedInterval == 'Année') {
      for (var tournee in tournees) {
        data.add(IntervalData(
          interval: tournee.annee.toString(),
          count: tournee.realises,
        ));
      }
    } else {
      for (var tournee in tournees) {
        for (var day in tournee.date) {
          if (selectedInterval == 'Jour' && day.jour != null) {
            data.add(IntervalData(
              interval: day.jour.toString(),
              count: day.realises,
            ));
          }
        }
      }
    }

    return [
      charts.Series<IntervalData, String>(
        id: 'tournees',
        domainFn: (IntervalData data, _) => data.interval,
        measureFn: (IntervalData data, _) => data.count,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bar Chart Demo'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => changeInterval('Jour'),
                  child: Text('Jour'),
                ),
                ElevatedButton(
                  onPressed: () => changeInterval('Mois'),
                  child: Text('Mois'),
                ),
                ElevatedButton(
                  onPressed: () => changeInterval('Année'),
                  child: Text('Année'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: charts.BarChart(
                _createChartData(),
                animate: true,
                domainAxis: charts.OrdinalAxisSpec(
                  renderSpec: charts.SmallTickRendererSpec(
                    labelRotation: 60,
                  ),
                ),
                primaryMeasureAxis: charts.NumericAxisSpec(
                  renderSpec: charts.SmallTickRendererSpec(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TourneeData {
  final String mois;
  final int annee;
  final int realises;
  final List<DayData> date;

  TourneeData({
    required this.mois,
    required this.annee,
    required this.realises,
    required this.date,
  });
}

class DayData {
  final int jour;
  final int realises;

  DayData({required this.jour, required this.realises});
}

class IntervalData {
  final String interval;
  final int count;

  IntervalData({required this.interval, required this.count});
}
