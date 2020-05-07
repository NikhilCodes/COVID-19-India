import 'package:covid19tracker/helper_functions.dart';
import 'package:covid19tracker/special_widgets.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TotalGrowthTrends extends StatefulWidget {
  TotalGrowthTrends({this.data, this.enableDark});

  final Map data;
  final bool enableDark;

  @override
  State<StatefulWidget> createState() {
    return _TotalGrowthTrendsState();
  }
}

class _TotalGrowthTrendsState extends State<TotalGrowthTrends> {
  @override
  Widget build(BuildContext context) {
    bool enableDark = widget.enableDark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            enableDark ? Colors.transparent : Color.fromRGBO(235, 240, 255, 1),
        elevation: 0,
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: enableDark ? Colors.white : Colors.indigo,
          ),
          onTap: () => Navigator.of(context).pop(),
        ),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(
              "Cases",
              style: TextStyle(
                color: enableDark
                    ? Colors.deepPurpleAccent.shade100
                    : Colors.deepPurple,
                letterSpacing: 2,
                fontWeight: FontWeight.w900,
                fontSize: 30,
              ),
            ),
            SizedBox(width: 5),
            Text(
              "Trends",
              style: TextStyle(
                color: enableDark ? Colors.indigoAccent : Colors.indigo,
                fontWeight: FontWeight.w400,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: enableDark
          ? Colors.white.withOpacity(0.2)
          : Color.fromRGBO(235, 240, 255, 1),
      body: Builder(
        builder: (BuildContext context) {
          String hash;
          List<PandemicData> dataPointsConfirmed = List(),
              dataPointsRecovered = List(),
              dataPointsDeceased = List(),
              dataPointsDailyConfirmed = List(),
              dataPointsDailyRecovered = List(),
              dataPointsDailyDeceased = List();

          widget.data["cases_time_series"].forEach((element) {
            hash = element["date"].substring(0, 6);
            dataPointsConfirmed.add(PandemicData(
                n: int.parse(element["totalconfirmed"]), date: hash));
            dataPointsRecovered.add(PandemicData(
                n: int.parse(element["totalrecovered"]), date: hash));
            dataPointsDeceased.add(PandemicData(
                n: int.parse(element["totaldeceased"]), date: hash));

            dataPointsDailyConfirmed.add(PandemicData(
                n: int.parse(element["dailyconfirmed"]), date: hash));
            dataPointsDailyRecovered.add(PandemicData(
                n: int.parse(element["dailyrecovered"]), date: hash));
            dataPointsDailyDeceased.add(PandemicData(
                n: int.parse(element["dailydeceased"]), date: hash));
          });

          return ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(left: 16, right: 16, top: 10),
            children: <Widget>[
              RoundedTile(
                backgroundColor:
                    enableDark ? Color.fromRGBO(20, 20, 20, 1) : Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        zoomPanBehavior: ZoomPanBehavior(
                          enableDoubleTapZooming: true,
                          enablePanning: true,
                          zoomMode: ZoomMode.x,
                          enableMouseWheelZooming: true,
                          enablePinching: true,
                        ),
                        title: ChartTitle(text: "Total Cases"),
                        legend: Legend(
                            isVisible: true, position: LegendPosition.bottom),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <LineSeries<PandemicData, String>>[
                          LineSeries<PandemicData, String>(
                            dataSource: dataPointsConfirmed,
                            xValueMapper: (PandemicData data, _) => data.date,
                            yValueMapper: (PandemicData data, _) => data.n,
                            color: Colors.blue,
                            legendItemText: "Confirmed",
                            enableTooltip: true,
                            legendIconType: LegendIconType.triangle,
                          ),
                          LineSeries<PandemicData, String>(
                            dataSource: dataPointsRecovered,
                            xValueMapper: (PandemicData data, _) => data.date,
                            yValueMapper: (PandemicData data, _) => data.n,
                            color: Colors.green,
                            legendItemText: "Recovered",
                            legendIconType: LegendIconType.triangle,
                          ),
                          LineSeries<PandemicData, String>(
                            dataSource: dataPointsDeceased,
                            xValueMapper: (PandemicData data, _) => data.date,
                            yValueMapper: (PandemicData data, _) => data.n,
                            color: Colors.red,
                            legendItemText: "Deceased",
                            legendIconType: LegendIconType.triangle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              RoundedTile(
                backgroundColor:
                    enableDark ? Color.fromRGBO(20, 20, 20, 1) : Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: SfCartesianChart(
                        primaryXAxis: CategoryAxis(),
                        zoomPanBehavior: ZoomPanBehavior(
                          enableDoubleTapZooming: true,
                          enablePanning: true,
                          zoomMode: ZoomMode.x,
                          enableMouseWheelZooming: true,
                          enablePinching: true,
                        ),
                        title: ChartTitle(text: "Daily Cases"),
                        legend: Legend(
                            isVisible: true, position: LegendPosition.bottom),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <LineSeries<PandemicData, String>>[
                          LineSeries<PandemicData, String>(
                            dataSource: dataPointsDailyConfirmed,
                            xValueMapper: (PandemicData data, _) => data.date,
                            yValueMapper: (PandemicData data, _) => data.n,
                            color: Colors.blue,
                            legendItemText: "Confirmed",
                            enableTooltip: true,
                            legendIconType: LegendIconType.triangle,
                          ),
                          LineSeries<PandemicData, String>(
                            dataSource: dataPointsDailyRecovered,
                            xValueMapper: (PandemicData data, _) => data.date,
                            yValueMapper: (PandemicData data, _) => data.n,
                            color: Colors.green,
                            legendItemText: "Recovered",
                            legendIconType: LegendIconType.triangle,
                          ),
                          LineSeries<PandemicData, String>(
                            dataSource: dataPointsDailyDeceased,
                            xValueMapper: (PandemicData data, _) => data.date,
                            yValueMapper: (PandemicData data, _) => data.n,
                            color: Colors.red,
                            legendItemText: "Deceased",
                            legendIconType: LegendIconType.triangle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
            ],
          );
        },
      ),
    );
  }
}
