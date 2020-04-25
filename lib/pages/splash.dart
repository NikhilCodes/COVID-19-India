import 'package:covid19tracker/pages/home_page.dart';
import 'package:flare_loading/flare_loading.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';


class SplashScreen extends StatelessWidget {

  Future getFutureData() async {
    final response = await http.get("https://api.covid19india.org/data.json");

    if(response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print("Unable to fetch json data");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlareLoading(
        name: "assets/Covid-19.flr",
        startAnimation: "Untitled",
        fit: BoxFit.cover,
        onError: (error, stacktrace) {},
        onSuccess: (data) async {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MyHomePage(futureData: getFutureData(),))
          );
        },
      ),
    );
  }
}
