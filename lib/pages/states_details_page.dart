import 'package:covid19tracker/special_widgets.dart';
import 'package:flutter/material.dart';

class StateDetailsPage extends StatefulWidget {
  StateDetailsPage({this.data});

  final Map data;

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
    var data = widget.data["statewise"].sublist(1);
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
              "State",
              style: TextStyle(
                color: Colors.deepPurple,
                letterSpacing: 2,
                fontWeight: FontWeight.w900,
                fontSize: 30,
              ),
            ),
            SizedBox(width: 5),
            Text(
              "Details",
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
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(width: 2, color: Colors.deepPurple),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(width: 2, color: Colors.deepPurple),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide:
                        BorderSide(width: 3, color: Colors.deepPurpleAccent),
                  ),
                ),
                style: TextStyle(
                  fontFamily: "Rubik",
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          data[index]["state"],
                          style: TextStyle(
                            fontFamily: "Rubik",
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
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
                                color: Colors.deepPurple.shade700,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "${data[index]["deltaconfirmed"]}",
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Rubik",
                                    fontSize: 18,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_upward,
                                  size: 17,
                                  color: Colors.blueGrey,
                                ),
                                Text(
                                  "${data[index]["confirmed"]}".padLeft(7),
                                  style: TextStyle(
                                    fontFamily: "monospace",
                                    fontSize: 18,
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
                                color: Colors.deepPurple.shade700,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "${data[index]["deltarecovered"]}",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Rubik",
                                    fontSize: 18,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_upward,
                                  size: 17,
                                  color: Colors.green,
                                ),
                                Text(
                                  "${data[index]["recovered"]}".padLeft(7),
                                  style: TextStyle(
                                    fontFamily: "monospace",
                                    fontSize: 18,
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
                                color: Colors.deepPurple.shade700,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "${data[index]["deltadeaths"]}",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Rubik",
                                    fontSize: 18,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_upward,
                                  size: 17,
                                  color: Colors.red,
                                ),
                                Text(
                                  "${data[index]["deaths"]}".padLeft(7),
                                  style: TextStyle(
                                    fontFamily: "monospace",
                                    fontSize: 18,
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
