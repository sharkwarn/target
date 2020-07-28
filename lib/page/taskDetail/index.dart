/// 这是一个有状态组件，有状态组件必须由两部分构成。StatefulWidget 和 State

import 'package:flutter/material.dart';
import 'package:flutter/Cupertino.dart';
import '../../components/taskDetail/index.dart';
import '../../components/checklog/index.dart';
import '../../globalData/index.dart';
import '../../types/index.dart';
import '../../utils/date.dart';

class TaskDetail extends StatefulWidget {
  _TaskDetail createState() => new _TaskDetail();
}

class _TaskDetail extends State {
  int count = 0;

  bool _change = false;

  TypesTask detail;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _getDetail();
    });
  }

  _getDetail() async {
    int id = ModalRoute.of(context).settings.arguments;
    final _detail = await GlobalData.getDetail(id);
    setState(() {
      detail = TypesTask.fromMap(_detail);
    });
  }

  _reload() {
    _getDetail();
    setState(() {
      _change = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (detail == null) {
      return Container();
    }
    List<Widget> lists = [];
    lists.add(
      new Container(
        child: new Column(
          children: <Widget>[
            Container(
              child: new TaskDetail1(
                id: detail.id,
                title: detail.title,
                target: detail.target,
                dateCreated: detail.dateCreated,
                allDays: detail.allDays,
                holidayDays: detail.holidayDays,
                dayofftaken: detail.dayofftaken,
                isfine: detail.isfine,
                fine: detail.fine,
                supervisor: detail.supervisor,
                checklogs: detail.checklogs,
                status: detail.status,
                lastUpdate: detail.lastUpdate,
                reload: () {
                  _reload();
                }
              )
            ),
          ],
        )
      )
    );
    String nowTime = DateTime.now().toString();
    int isCheck;
    if (detail.checklogs != null && detail.checklogs.length != 0) {
      isCheck = DateMoment.getDayDifference(nowTime, detail.checklogs[0].checkTime);
    }
    if (isCheck != 0) {
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
                    Text('当前未签到'),
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
                          int id = ModalRoute.of(context).settings.arguments;
                          Navigator.of(context).pushNamed('/checktask', arguments: id).then((value) => {
                            if (value == true) {
                              _reload()
                            }
                          });
                        },
                        child: Text(
                          "点击签到",
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
    }
    detail.checklogs.forEach((item) {
      lists.add(
        CheckLog(
          checkTime: item.checkTime,
          remark: item.remark,
          isVacation: item.isVacation
        )
      );
    });
    lists.add(
      Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('创建时间' + DateMoment.getDate(detail.dateCreated))
          ],
        ),
      )
    );
    return new Scaffold(
        appBar: new AppBar(
          leading: GestureDetector(child: Icon(Icons.arrow_back_ios),onTap: (){
            Navigator.pop(context, _change);
          }),
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
