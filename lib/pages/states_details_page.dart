import 'package:covid19tracker/special_widgets.dart';
import 'package:flutter/material.dart';

class StateDetailsPage extends StatefulWidget {
  StateDetailsPage({this.data, this.enableDark});

  final Map data;
  final bool enableDark;

  @override
  State<StatefulWidget> createState() {
    return StateDetailsPageState();
  }
}

class StateDetailsPageState extends State<StateDetailsPage> {
  TextEditingController _textEditingController = TextEditingController();
  String searchKeyWord = "";

  @override
  Widget build(BuildContext context) {
    var enableDark = widget.enableDark;
    var data = widget.data["statewise"].sublist(1);
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
              "State",
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
              "Details",
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
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 18),
            child: SizedBox(
              height: 0.07 * MediaQuery.of(context).size.height,
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  labelText: "Search State",
                  labelStyle: TextStyle(
                      color: enableDark ? Colors.white : Colors.black),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      width: 2,
                      color: enableDark
                          ? Colors.deepPurpleAccent
                          : Colors.deepPurple,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      width: 2,
                      color: enableDark
                          ? Colors.deepPurpleAccent
                          : Colors.deepPurple,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      width: 3,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                ),
                style: TextStyle(
                    fontFamily: "Rubik",
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: enableDark ? Colors.white : Colors.black),
                onChanged: (value) {
                  setState(() {
                    searchKeyWord = value.toLowerCase();
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(left: 16, right: 16, top: 16),
              itemBuilder: (context, index) {
                if (!(searchKeyWord.trim() == "" ||
                    data[index]["state"].toLowerCase().contains(searchKeyWord)))
                  return Container();

                return Padding(
                  padding: EdgeInsets.only(bottom: 25),
                  child: RoundedTile(
                    backgroundColor: enableDark
                        ? Color.fromRGBO(20, 20, 20, 1)
                        : Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          data[index]["state"],
                          style: TextStyle(
                            fontFamily: "Rubik",
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: enableDark ? Colors.white : Colors.black,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Confirmed",
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: "Rubik",
                                color: enableDark
                                ? Colors.indigoAccent.shade100
                                : Colors.deepPurple.shade700,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "${data[index]["deltaconfirmed"]}",
                                  style: TextStyle(
                                    color: enableDark
                                        ? Colors.blueGrey.shade200
                                        : Colors.blueGrey,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Rubik",
                                    fontSize: 18,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_upward,
                                  size: 17,
                                  color: enableDark
                                      ? Colors.blueGrey.shade200
                                      : Colors.blueGrey,
                                ),
                                Text(
                                  "${data[index]["confirmed"]}".padLeft(7),
                                  style: TextStyle(
                                    fontFamily: "monospace",
                                    fontSize: 18,
                                    color: enableDark ? Colors.white : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Recovered",
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: "Rubik",
                                color: enableDark
                                    ? Colors.indigoAccent.shade100
                                    : Colors.deepPurple.shade700,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "${data[index]["deltarecovered"]}",
                                  style: TextStyle(
                                    color: enableDark
                                        ? Colors.greenAccent
                                        : Colors.green,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Rubik",
                                    fontSize: 18,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_upward,
                                  size: 17,
                                  color: enableDark
                                      ? Colors.greenAccent
                                      : Colors.green,
                                ),
                                Text(
                                  "${data[index]["recovered"]}".padLeft(7),
                                  style: TextStyle(
                                    fontFamily: "monospace",
                                    fontSize: 18,
                                    color: enableDark ? Colors.white : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Deceased",
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: "Rubik",
                                color: enableDark
                                    ? Colors.indigoAccent.shade100
                                    : Colors.deepPurple.shade700,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "${data[index]["deltadeaths"]}",
                                  style: TextStyle(
                                    color: enableDark
                                        ? Colors.redAccent.shade100
                                        : Colors.redAccent,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Rubik",
                                    fontSize: 18,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_upward,
                                  size: 17,
                                  color: enableDark
                                      ? Colors.redAccent.shade100
                                      : Colors.redAccent,
                                ),
                                Text(
                                  "${data[index]["deaths"]}".padLeft(7),
                                  style: TextStyle(
                                    fontFamily: "monospace",
                                    fontSize: 18,
                                    color: enableDark ? Colors.white : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: widget.data["statewise"].length - 1,
            ),
          ),
        ],
      ),
    );
  }
}
