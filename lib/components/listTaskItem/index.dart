import 'package:flutter/material.dart';
import 'package:flutter/Cupertino.dart';
import '../tapBox/index.dart';

import '../progressLine/index.dart';


class ListTaskItem extends StatefulWidget {

  const ListTaskItem({
    Key key,
    this.title,
    this.allDays,
    this.holidayDays,
    this.dayofftaken,
    this.onTap,
  }) : super(key: key);

  final String title;

  final int allDays;

  final int holidayDays;
  
  final int dayofftaken;
  
  final GestureTapCallback onTap;

  @override
  _ListTaskItem createState() => _ListTaskItem();
}


class _ListTaskItem extends State<ListTaskItem> {

  @override
  void initState() {
    super.initState();
  }

  _setData() async {
    
  }

  @override
  Widget build(BuildContext context) {
    final String title = widget.title;
    final int allDays = widget.allDays;
    final int holidayDays = widget.holidayDays;
    final int dayofftaken = widget.dayofftaken;
    final int surplusDay = holidayDays - dayofftaken;
    final double marginBottom = 10;
    return new Container(
      padding: EdgeInsets.fromLTRB(0, 4.0, 0, 4.0),
      child: new Card(
        child: new TapBox(
          onTap: () {
            widget.onTap();
          },
          child: new Container(
            padding: new EdgeInsets.all(16.0),
            child: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new Container(
                      child: new Text(
                        title,
                        style: new TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      )
                    )
                  ],
                ),
                new Container(
                  height: marginBottom,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Text('进度: '),
                        new Text(allDays.toString())
                      ]
                    ),
                    new Row(
                      children: <Widget>[
                        new Icon(
                          Icons.timer
                        ),
                        new Text('剩余' + surplusDay.toString() + '天假期')
                      ],
                    )
                  ],
                ),
                new Container(
                  height: marginBottom,
                ),
                new ProgressLine(
                  sum: allDays,
                  current: 1
                ),
                new Container(
                  height: marginBottom,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text('围观'),
                    new Container(),
                    new CupertinoButton(
                      color: Colors.red,
                      minSize: 1,
                      padding: EdgeInsetsDirectional.fromSTEB(6, 1, 6, 1),
                      borderRadius: BorderRadius.all(Radius.circular(14.0)),
                      onPressed: _setData,
                      child: Text(
                        "签到",
                        style: TextStyle(
                          fontSize: 14
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
          )
        )
      )
    );
  }
}