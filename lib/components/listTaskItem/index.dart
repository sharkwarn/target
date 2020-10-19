import 'package:flutter/material.dart';
import 'package:flutter/Cupertino.dart';
import '../tapBox/index.dart';
import '../progressLine/index.dart';

import '../../utils/colorsUtil.dart';

import '../../theme/colorsSetting.dart';

import '../../types/index.dart';


class ListTaskItem extends StatefulWidget {

  ListTaskItem({
    Key key,
    this.taskId,
    this.title,
    this.allDays,
    this.holidayDays,
    this.dayofftaken,
    this.onTap,
    this.tagInfo,
    this.currentStatus,
    this.currentDay,
    this.status,
    this.completedDay
  }) : super(key: key);

  final int taskId;

  final String title;

  final int allDays;

  final int holidayDays;
  
  final int dayofftaken;

  final int currentDay;
  
  final GestureTapCallback onTap;

  final Tag tagInfo;

  final String currentStatus;

  final String status;

  final int completedDay;

  @override
  _ListTaskItem createState() => _ListTaskItem();
}

class _ListTaskItem extends State<ListTaskItem> {

  @override
  void initState() {
    super.initState();
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

    String currentStatus;
    Color currentStatusColor;
    String status = widget.status;
    Color taskStatusColor;
    String taskStatus;
    switch (status) {
      case 'ongoing':
        taskStatus = (widget.completedDay ?? 0).toString();
        taskStatusColor = ColorsUtil.hexStringColor(tagColor);
        break;
      case 'success':
        taskStatus = '完成';
        taskStatusColor = Colors.green;
        break;
      case 'fail':
        taskStatus = '失败';
        taskStatusColor = Colors.red;
        break;
      default:
        taskStatus = statusDesc[widget.status] ?? ' ';
        taskStatusColor = Colors.red;
        break;
    }
    switch (widget.currentStatus) {
      case 'nosign':
        currentStatus = '签到';
        currentStatusColor = ColorsUtil.hexStringColor(tagColor);
        break;
      case 'done':
        currentStatus = '已签到';
        currentStatusColor = Colors.grey;
        break;
      default:
        currentStatus = ' ';
        currentStatusColor = Colors.blue;
        break;
    }
    return new Container(
      child: new Card(
        elevation: 10,
        margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
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
                      Offstage(
                        child: TapBox(
                          onTap: () {
                            print('点击了');
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: currentStatusColor,
                            ),
                            child: Text(
                              currentStatus,
                              style: new TextStyle(
                                  color: Colors.white,
                              )
                            ),
                          ),
                        ),
                        offstage: status != 'ongoing',
                      )
                    ],
                  ),
                ),
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
                              new Text(taskStatus)
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
                    current: status == 'ongoing' ? widget.completedDay ?? 0 : allDays,
                    color: taskStatusColor,
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