import 'package:bezier_chart/bezier_chart.dart';
import 'package:covid19tracker/special_widgets.dart';
import 'package:flutter/material.dart';

class TotalGrowthTrends extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TotalGrowthTrendsState();
  }
}

class _TotalGrowthTrendsState extends State<TotalGrowthTrends> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(235, 240, 255, 1),
        elevation: 0,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.indigo,
          ),
          onTap: () => Navigator.of(context).pop(),
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              "Cases",
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
              "Trends",
              style: TextStyle(
                color: Colors.indigo,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromRGBO(235, 240, 255, 1),
      body: ListView(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10),
        children: <Widget>[
          RoundedTile(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width * 0.9,
              child: BezierChart(
                bezierChartScale: BezierChartScale.CUSTOM,
                xAxisCustomValues: const [0, 5, 10, 15, 20, 25, 30, 35],
                series: const [
                  BezierLine(
                    lineColor: Colors.blue,
                    lineStrokeWidth: 2,
                    dataPointStrokeColor: Colors.indigo,
                    dataPointFillColor: Colors.indigo,
                    data: const [
                      DataPoint<double>(value: 10, xAxis: 0),
                      DataPoint<double>(value: 130, xAxis: 5),
                      DataPoint<double>(value: 50, xAxis: 10),
                      DataPoint<double>(value: 150, xAxis: 15),
                      DataPoint<double>(value: 75, xAxis: 20),
                      DataPoint<double>(value: 0, xAxis: 25),
                      DataPoint<double>(value: 5, xAxis: 30),
                      DataPoint<double>(value: 45, xAxis: 35),
                    ],
                  ),
                ],
                config: BezierChartConfig(
                  verticalIndicatorStrokeWidth: 2.0,
                  verticalIndicatorColor: Colors.black38,
                  showVerticalIndicator: true,
                  verticalIndicatorFixedPosition: true,
                  xLinesColor: Colors.black,
                  pinchZoom: true,
                  showDataPoints: true,
                  footerHeight: 30.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
