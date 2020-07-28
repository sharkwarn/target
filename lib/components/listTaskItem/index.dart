import 'package:flutter/material.dart';
import 'package:flutter/Cupertino.dart';
import '../tapBox/index.dart';
import '../progressLine/index.dart';

import '../../utils/colorsUtil.dart';

import '../../types/index.dart';


class ListTaskItem extends StatefulWidget {

  ListTaskItem({
    Key key,
    this.title,
    this.allDays,
    this.holidayDays,
    this.dayofftaken,
    this.onTap,
    this.tagInfo,
  }) : super(key: key);

  final String title;

  final int allDays;

  final int holidayDays;
  
  final int dayofftaken;
  
  final GestureTapCallback onTap;

  final Tag tagInfo;

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
    String tagName = widget?.tagInfo?.name;
    String tagColor = widget?.tagInfo?.color;
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
                Offstage(
                  offstage: tagName == null,
                  child: Container(
                    child: Row(children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(3, 1, 3, 1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: tagColor != null ? ColorsUtil.hexStringColor(tagColor) : Colors.white,
                        ),
                        child: Text(
                          tagName == null ? '' : tagName,
                          style: TextStyle(
                            color: Colors.white
                          )
                        )
                      )
                    ],)
                  ),
                ),
              ],
            )
          )
        )
      )
    );
  }
}