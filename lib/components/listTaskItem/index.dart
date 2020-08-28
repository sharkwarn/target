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
    String tagName = widget?.tagInfo?.name;
    String tagColor = widget?.tagInfo?.color;
    return new Container(
      child: new Card(
        elevation: 10,
        margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: new TapBox(
          onTap: () {
            widget.onTap();
          },
          child: new Container(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: new Column(
              children: <Widget>[
                Container(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: new Text(
                            title,
                            style: new TextStyle(
                              fontSize: 18.0,
                              color: ColorsUtil.hexStringColor(tagColor),
                            ),
                          )
                        ),
                      ),
                      Container(
                        height: 80,
                        width: 80,
                        child: Icon(
                          Icons.check_circle,
                          color: ColorsUtil.hexStringColor(tagColor)
                        ),
                      )
                    ],
                  ),
                ),
                // ClipPath(
                //   clipper: BorderBottom(),
                //   child: Container(
                //       width: double.infinity,
                //       color: Colors.white,
                //       height: 6,
                //     ),
                // ),
                Container(
                  color: ColorsUtil.hexStringColor(tagColor),
                  height: 1,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
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
                    ]
                  )
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                  color: Colors.white,
                  child: ProgressLine(
                    sum: allDays,
                    current: 2,
                    color: ColorsUtil.hexStringColor(tagColor),
                  )
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