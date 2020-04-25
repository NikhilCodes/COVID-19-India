import 'package:covid19tracker/pages/home_page.dart';
import 'package:covid19tracker/pages/splash.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COVID19-live',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
