import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:convert';

final months = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December",
];

Future getFutureData() async {
  final response = await http.get("https://api.covid19india.org/data.json");

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    print("Unable to fetch json data");
    return null;
  }
}

int dateHash(String date) {
  int n = 0;

  var segments = date.split(" ");
  int month = months.indexOf(segments[1]), day = int.parse(segments[0]);

  n = (32 * month) + day;
  return n;
}

class PandemicData {
  final int n;
  final int dateHash;

  PandemicData({this.n, this.dateHash});
}

getConfirmedCasesData(data) {
  List<charts.Series<PandemicData, int>> series = [
    charts.Series(
      labelAccessorFn: (PandemicData row, _) => '${row.n}',
      id: "No. of Patient",
      data: data,
      domainFn: (PandemicData series, _) => series.dateHash,
      measureFn: (PandemicData series, _) => series.n,
      colorFn: (PandemicData series, _) =>
          charts.MaterialPalette.blue.shadeDefault,
    )
  ];

  return series;
}
