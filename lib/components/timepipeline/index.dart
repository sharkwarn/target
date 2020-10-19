import 'package:flutter/material.dart';

import '../../theme/colorsSetting.dart';

class TimePipeline extends StatelessWidget{
  TimePipeline({
    Key key,
    this.date,
    this.time,
    this.status,
    this.remark
  }) : super(key: key);

  final String date;

  final String time;

  final String status;

  final String remark;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 140,
                      padding: EdgeInsets.fromLTRB(16, 4, 12, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
                            child: Text(
                              date,
                              style: TextStyle(
                                color: statusColors[status],
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              )
                            )
                          ),
                          Text(
                            time,
                            style: TextStyle(
                              color: statusColors[status],
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            )
                          )
                        ],
                      )
                    ),
                    Container(
                      width: 30,
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
                                    decoration: BoxDecoration(
                                      color: statusColors[status],
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow:  [
                                        BoxShadow(
                                          color: statusColors[status],
                                          blurRadius: 5.0,
                                        )
                                      ]
                                    ),
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          // 定义一个最小宽度
                                          Container(
                                            width: 120,
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
                                            child: Text(
                                              statusDesc[status],
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              )
                                            )
                                          ),
                                          Container(
                                            child: Text(
                                              remark,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              )
                                            )
                                          ),
                                        ]
                                      )
                                    )
                                  )
                                ]
                              )
                            ),
                          ),
                          Container(
                            width: 16,
                          )
                        ],
                      )
                    )
                  ],
                ),
              ),
              Positioned(
                left: 140,
                bottom: 0,
                top: 0,
                child: Container(
                  width: 30,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 15,
                        width: 1,
                        color: Colors.grey
                      ),
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: statusColors[status],
                          borderRadius: BorderRadius.circular(30),
                          boxShadow:  [
                            BoxShadow(
                              color: statusColors[status],
                              blurRadius: 5.0,
                            )
                          ]
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: 1,
                          color: Colors.grey
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ]
      )
    );
  }
}