import 'package:flutter/material.dart';

class TaskDetail1 extends StatefulWidget {
  const TaskDetail1({
    Key key,
  }) : super(key: key);

  @override
  _TaskDetail createState() => _TaskDetail();
}


class _TaskDetail extends State<TaskDetail1> {

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Row(children: <Widget>[
                Container(
                  child: Text('每天不犯同样的错误'),
                )
              ],),
              Row(children: <Widget>[
                Container(
                  child: Text('目标动机：' + '为了减肥'),
                )
              ],),
              Container(
                color: Colors.green,
                padding: EdgeInsets.fromLTRB(16, 5, 16, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text('¥ 1.00'),
                          Text('挑战金')
                        ]
                      )
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text('4/10'),
                          Text('坚持天数')
                        ]
                      )
                    )
                  ],
                )
              ),
            ],
          ),
        )
      ],
    );
  }
}