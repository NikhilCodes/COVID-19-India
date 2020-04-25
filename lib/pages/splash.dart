import 'package:covid19tracker/helper_functions.dart';
import 'package:covid19tracker/pages/home_page.dart';
import 'package:flare_loading/flare_loading.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
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
            MaterialPageRoute(
              builder: (context) => MyHomePage(
                futureData: getFutureData(),
              ),
            ),
          );
        },
      ),
    );
  }
}
