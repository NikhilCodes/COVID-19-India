import 'package:bezier_chart/bezier_chart.dart';
import 'package:covid19tracker/helper_functions.dart';
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
                color: Colors.deepPurple,
                letterSpacing: 2,
                fontWeight: FontWeight.w900,
                fontSize: 30,
              ),
            ),
            SizedBox(width: 5),
            Text(
              "Trends",
              style: TextStyle(
                color: Colors.indigo,
                fontWeight: FontWeight.w400,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromRGBO(235, 240, 255, 1),
      body: FutureBuilder(
        future: getFutureData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          double hash;
          List<double> xAxisCustomValuesHash = [];
          List<DataPoint<double>> dataPoints = [];

          snapshot.data["cases_time_series"].forEach((element) {
            hash = dateHash(element["date"]).toDouble();
            xAxisCustomValuesHash.add(hash);
            dataPoints.add(
              DataPoint<double>(
                value: double.parse(element["totalconfirmed"]),
                xAxis: hash,
              ),
            );
          });

          return ListView(
            padding: EdgeInsets.only(left: 16, right: 16, top: 10),
            children: <Widget>[
              RoundedTile(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: BezierChart(
                    selectedValue: xAxisCustomValuesHash.last,
                    bezierChartScale: BezierChartScale.CUSTOM,
                    xAxisCustomValues: xAxisCustomValuesHash,
                    bubbleLabelValueBuilder: (value) {
                      int month = (value / 32).floor();
                      int day = (value % 32).toInt();
                      return "$day/${month + 1}\n";
                    },
                    footerValueBuilder: (value) {
                      return "";
                    },
                    series: [
                      BezierLine(
                        lineColor: Colors.deepPurple,
                        lineStrokeWidth: 2,
                        dataPointStrokeColor: Colors.indigo,
                        dataPointFillColor: Colors.indigo,
                        data: dataPoints,
                      ),
                    ],
                    config: BezierChartConfig(
                      contentWidth: 1000,
                      startYAxisFromNonZeroValue: true,
                      stepsYAxis: 100,
                      showVerticalIndicator: true,
                      physics: BouncingScrollPhysics(),
                      verticalIndicatorStrokeWidth: 1.0,
                      verticalIndicatorColor: Colors.black38,
                      xLinesColor: Colors.black,
                      pinchZoom: true,
                      footerHeight: 60.0,
                      showDataPoints: false,
                      xAxisTextStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
