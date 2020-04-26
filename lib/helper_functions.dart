import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

DateTime getDateTimeObj(String date) {
  var segments = date.split(" ");
  int month = months.indexOf(segments[1]), day = int.parse(segments[0]);

  var dateTime = DateTime(2019, month+1, day);

  return dateTime;
}

class PandemicData {
  final int n;
  final String date;

  PandemicData({this.n, this.date});
}
