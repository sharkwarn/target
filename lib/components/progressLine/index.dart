import 'package:flutter/material.dart';

class ProgressLine extends StatelessWidget {

  ProgressLine({
    this.sum,
    this.current,
    this.color
  }) : super();

  final int sum;

  final int current;

  final Color color;

  @override
  Widget build(BuildContext context) {
    final int currentPercent = ((this.current * 100)/this.sum).floor();
    final int otherPercent = 100 - currentPercent;
    const double height = 10.0;
    return new Container(
      height: height,
      decoration: new BoxDecoration(
        color: Colors.grey[200],
        borderRadius: new BorderRadius.all(
          Radius.circular(height),
        ), 
      ),
      child: new Row(
        children: <Widget>[
          new Expanded(
            flex: currentPercent,
            child: new Container(
              height: height,
              decoration: new BoxDecoration(
                color: color,
                borderRadius: new BorderRadius.all(
                  Radius.circular(height),
                ),
                // gradient: LinearGradient(
                //   colors: [Color(0xFFFFFFFF), Color(0xFF00FFFF)],
                //   tileMode: TileMode.repeated
                // )

              ),
            )
          ),
          new Expanded(
            flex: otherPercent,
            child: new Container(
              height: height,
              child: new Text('')
            ),
          )
        ],
      )
    );
  }
}


