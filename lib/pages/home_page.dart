import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:covid19tracker/helper_functions.dart';
import 'package:covid19tracker/pages/growthtrends_page.dart';
import 'package:covid19tracker/special_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int totalActiveCases,
      totalRecoveredCases,
      totalDeceasedCases,
      totalCases,
      deltaRecoveredCases,
      deltaDeceasedCases;

  List<Widget> top7StatesActiveTextWidgets;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(235, 240, 255, 1),
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              "COVID-19",
              style: TextStyle(
                fontFamily: "Rubik",
                color: Colors.deepPurple,
                letterSpacing: 2,
                fontWeight: FontWeight.w800,
                fontSize: 22,
              ),
            ),
            SizedBox(width: 5),
            Text(
              "India",
              style: TextStyle(
                color: Colors.indigo,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ],
        ),
        backgroundColor: Color.fromRGBO(235, 240, 255, 1),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Dashboard",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 5),
            Row(
              children: <Widget>[
                Container(
                  height: 10,
                  width: 58,
                  decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5))),
                ),
                Container(
                  height: 10,
                  width: 58,
                  color: Colors.blue,
                ),
                Container(
                  height: 10,
                  width: 58,
                  decoration: BoxDecoration(
                      color: Colors.cyanAccent.shade400,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5))),
                )
              ],
            ),
            SizedBox(height: 25),
            FutureBuilder(
              future: getFutureData(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  totalActiveCases =
                      int.parse(snapshot.data['statewise'][0]['active']);
                  totalRecoveredCases =
                      int.parse(snapshot.data['statewise'][0]['recovered']);
                  totalDeceasedCases =
                      int.parse(snapshot.data['statewise'][0]['deaths']);
                  totalCases = totalActiveCases +
                      totalDeceasedCases +
                      totalRecoveredCases;

                  deltaRecoveredCases = int.parse(
                      snapshot.data['statewise'][0]["deltarecovered"]);
                  deltaDeceasedCases =
                      int.parse(snapshot.data['statewise'][0]["deltadeaths"]);

                  top7StatesActiveTextWidgets = [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Active",
                          style: TextStyle(
                            fontFamily: "Rubik",
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.purple,
                          ),
                        ),
                        Text(
                          "State",
                          style: TextStyle(
                              fontFamily: "Rubik",
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.indigo),
                        )
                      ],
                    )
                  ];
                  snapshot.data["statewise"].sublist(1, 8).forEach((element) {
                    top7StatesActiveTextWidgets.add(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            element["active"],
                            style: TextStyle(
                              fontFamily: "Rubik",
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            element["state"],
                            style: TextStyle(
                              fontFamily: "Rubik",
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    );
                  });

                  return Expanded(
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: <Widget>[
                        RoundedTile(
                          child: Column(
                            children: <Widget>[
                              Center(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    AnimatedCircularChart(
                                      size: Size(300, 300),
                                      duration: Duration(seconds: 1),
                                      holeRadius: 60,
                                      startAngle: -180,
                                      chartType: CircularChartType.Radial,
                                      initialChartData: <CircularStackEntry>[
                                        CircularStackEntry(
                                          <CircularSegmentEntry>[
                                            CircularSegmentEntry(
                                              totalActiveCases.toDouble(),
                                              Colors.blueAccent[400],
                                              rankKey: 'Confirmed',
                                            ),
                                            CircularSegmentEntry(
                                              totalRecoveredCases.toDouble(),
                                              Colors.cyanAccent[400],
                                              rankKey: 'Recovered',
                                            ),
                                            CircularSegmentEntry(
                                              totalDeceasedCases.toDouble(),
                                              Colors.indigo,
                                              rankKey: 'Deaths',
                                            ),
                                          ],
                                          rankKey: '',
                                        ),
                                      ],
                                    ),
                                    Center(
                                      child: Container(
                                        height: 120,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(60),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              spreadRadius: 1,
                                              blurRadius: 6,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              totalCases.toString(),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "Rubik",
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              "Total Cases",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.blueAccent[400],
                                              borderRadius:
                                                  BorderRadius.circular(9),
                                            ),
                                            height: 18,
                                            width: 18,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            "Active",
                                            style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontFamily: "Rubik",
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        totalActiveCases.toString(),
                                        style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontFamily: "monospace",
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.cyanAccent[400],
                                              borderRadius:
                                                  BorderRadius.circular(9),
                                            ),
                                            height: 18,
                                            width: 18,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            "Recovered",
                                            style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontFamily: "Rubik",
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "$deltaRecoveredCases",
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontFamily: "Rubik",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_upward,
                                            size: 17,
                                            color: Colors.green,
                                          ),
                                          Text(
                                            totalRecoveredCases
                                                .toString()
                                                .padLeft(7),
                                            style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontFamily: "monospace",
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.indigo,
                                              borderRadius:
                                                  BorderRadius.circular(9),
                                            ),
                                            height: 18,
                                            width: 18,
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            "Deceased",
                                            style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontFamily: "Rubik",
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            "$deltaDeceasedCases",
                                            style: TextStyle(
                                              color: Colors.redAccent,
                                              fontFamily: "Rubik",
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_upward,
                                            size: 17,
                                            color: Colors.redAccent,
                                          ),
                                          Text(
                                            totalDeceasedCases
                                                .toString()
                                                .padLeft(7),
                                            style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontFamily: "monospace",
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          oneTap: () {
                            print("Tap1");
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => TotalGrowthTrends(),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 30),
                        RoundedTile(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Map",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Column(
                                children: top7StatesActiveTextWidgets,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ef/COVID-19_Outbreak_Cases_in_India.svg/1024px-COVID-19_Outbreak_Cases_in_India.svg.png",
                                  fadeInCurve: Curves.easeIn,
                                  height: 300,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                ),
                              ),
                            ],
                          ),
                          oneTap: () {
                            print("Tap");
                          },
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  );
                } else if (snapshot.hasData) {
                  return Center(child: Text("${snapshot.error}"));
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
