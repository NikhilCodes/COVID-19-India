import 'package:covid19tracker/helper_functions.dart';
import 'package:covid19tracker/special_widgets.dart';
import 'package:flutter/material.dart';
import 'package:bezier_chart/bezier_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

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

          int hash;
          List<PandemicData> dataPoints = [];

          snapshot.data["cases_time_series"].forEach((element) {
            hash = dateHash(element["date"]);
            dataPoints.add(
              PandemicData(
                n: int.parse(element["totalconfirmed"]),
                dateHash: hash,
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
                  child: charts.LineChart(
                    getConfirmedCasesData(dataPoints),
                    animate: true,
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
