import 'package:flutter/material.dart';

class RoundedTile extends StatefulWidget {
  RoundedTile({Key key, @required this.child}) : super(key: key);

  final Widget child;

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
      child: widget.child,
      decoration: BoxDecoration(
        color: Colors.white,
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
