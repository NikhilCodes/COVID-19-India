import 'package:flutter/material.dart';

class RoundedTile extends StatefulWidget {
  RoundedTile({Key key, @required this.child, this.oneTap, this.backgroundColor}) : super(key: key);

  final Widget child;
  final Function oneTap;
  final Color backgroundColor;

  @override
  State<StatefulWidget> createState() {
    return _RoundedTileState();
  }
}

class _RoundedTileState extends State<RoundedTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: GestureDetector(
        child: widget.child,
        onTap: widget.oneTap,
      ),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0, 4),
            blurRadius: 10,
            spreadRadius: -10
          ),
        ],
      ),
    );
  }
}

class TotalDataSelectionInfo extends StatefulWidget {
  TotalDataSelectionInfo({Key key, this.value1}) : super(key: key);

  final String value1;

  @override
  State<StatefulWidget> createState() {
    return _TotalDataSelectionInfoState();
  }
}

class _TotalDataSelectionInfoState extends State<TotalDataSelectionInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Text("Confirmed\n${widget.value1}"),
        ],
      ),
    );
  }

}
