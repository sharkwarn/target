/// 这是一个有状态组件，有状态组件必须由两部分构成。StatefulWidget 和 State

import 'package:flutter/material.dart';
import 'package:flutter/Cupertino.dart';
import '../../components/taskDetail/index.dart';
import '../../components/checklog/index.dart';
import '../../mock/index.dart';
import '../../globalData/index.dart';

class TaskDetail extends StatefulWidget {
  _TaskDetail createState() => new _TaskDetail();
}

class _TaskDetail extends State {
  int count = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      int id = ModalRoute.of(context).settings.arguments;
      print(id);
      _getDetail(id);
    });
  }

  _getDetail(id) async {
    var detail = await GlobalData.getDetail(id);
    print('找到了');
    print(detail);
  }


  @override
  Widget build(BuildContext context) {
    final List<Widget> lists = [];
    lists.add(
      new Container(
        child: new Column(
          children: <Widget>[
            Container(
              child: new TaskDetail1()
            ),
          ],
        )
      )
    );
    lists.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('头像'),
              Text('sara')
            ],
          ),
          Row(
            children: <Widget>[
              Text('报酬'),
              Text('¥1.00'),
              Icon(
                Icons.settings
              )
            ],
          )
        ],
      )
    );
    lists.add(
      Container(
        color: Colors.green,
        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Card(
          child: Row(
            children: <Widget>[
              Icon(
                Icons.headset
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('小五'),
                  Text('2020-07-08 12:12')
                ],
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    CupertinoButton(
                      color: Colors.red,
                      minSize: 1,
                      padding: EdgeInsetsDirectional.fromSTEB(6, 1, 6, 1),
                      borderRadius: BorderRadius.all(Radius.circular(14.0)),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/checktask');
                      },
                      child: Text(
                        "签到",
                        style: TextStyle(
                          fontSize: 14
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      )
    );
    DetailMock.checklogs.forEach((item) {
      lists.add(
        CheckLog()
      );
    });
    return new Scaffold(
        appBar: new AppBar(
          title: new TextField(
            obscureText: false
          )
        ),
        body: Container(
          child: new ListView(
            children: lists
          ),
        )
      );
  }
}
