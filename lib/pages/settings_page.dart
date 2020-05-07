import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({this.prefs, this.parent});

  final SharedPreferences prefs;
  final State parent;

  @override
  State<StatefulWidget> createState() {
    return _SettingsPageState();
  }
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    var enableDark = widget.prefs.getBool("enableDark");
    final tiles = <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Lights",
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headline5.fontSize,
              fontFamily: "Rubik",
              color: enableDark ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 10),
          LiteRollingSwitch(
            value: widget.prefs.getBool("enableDark") ? false : true,
            textOn: 'On',
            textOff: 'Off',
            colorOff: Colors.blueAccent,
            colorOn: Colors.black87,
            iconOn: Icons.brightness_low,
            iconOff: Icons.brightness_3,
            textSize: 24.0,
            onChanged: (bool state) async {
              await widget.prefs.setBool("enableDark", !state);
              setState(() {
                enableDark = !state;
              });
              widget.parent.setState(() {
                if (!state) {
                  widget.parent.setState(() { });
                }
              });
            },
          )
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Version",
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headline5.fontSize,
              fontFamily: "Rubik",
              color: enableDark ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "v1.3.2",
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headline6.fontSize,
              fontFamily: "Rubik",
              color: enableDark ? Colors.grey.shade300 : Colors.grey.shade600,
            ),
          )
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Developer",
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headline5.fontSize,
              fontFamily: "Rubik",
              color: enableDark ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Nikhil Nayak",
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headline6.fontSize,
              fontFamily: "Rubik",
              color: enableDark ? Colors.grey.shade300 : Colors.grey.shade600,
            ),
          )
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Contact",
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headline5.fontSize,
              fontFamily: "Rubik",
              color: enableDark ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "nikhil.nixel@gmail.com",
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headline6.fontSize,
              fontFamily: "Rubik",
              color: enableDark ? Colors.grey.shade300 : Colors.grey.shade600,
            ),
          )
        ],
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Settings",
          style: TextStyle(
            fontFamily: "Rubik",
            color: enableDark ? Colors.deepPurpleAccent.shade100 : Colors.deepPurple,
          ),
        ),
        backgroundColor: enableDark
            ? Colors.white.withOpacity(0.2)
            : Color.fromRGBO(235, 240, 255, 1),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios, color: enableDark ? Colors.white : Colors.indigo),
          onTap: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: enableDark
          ? Colors.white.withOpacity(0.2)
          : Color.fromRGBO(235, 240, 255, 1),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        itemBuilder: (context, index) => tiles[index],
        separatorBuilder: (context, index) =>
            Divider(color: Theme.of(context).dividerColor),
        itemCount: 4,
      ),
    );
  }
}
