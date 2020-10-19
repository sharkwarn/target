/// 这是一个有状态组件，有状态组件必须由两部分构成。StatefulWidget 和 State

import 'package:flutter/material.dart';
import 'package:flutter/Cupertino.dart';
import 'package:loading_animations/loading_animations.dart';
import '../../components/taskDetail/index.dart';
import '../../components/checklog/index.dart';
import '../../components/progressCircle/index.dart';
import '../../types/index.dart';
import '../../utils/colorsUtil.dart';
import '../../utils/request/index.dart';
import '../../config.dart';

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
    int taskId = ModalRoute.of(context).settings.arguments;
    final result = await Request.post(Urls.env + '/task/detail', {
      'taskId': taskId
    });
    if (result != null && result['success'] == true) {
      setState(() {
        detail = TypesTask.fromMap(result['data']);
      });
    }
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
      return new Scaffold(
        appBar: new AppBar(
          leading: GestureDetector(child: Icon(Icons.arrow_back_ios),onTap: (){
            Navigator.pop(context, _change);
          }),
          title: Text('')
        ),
        backgroundColor: Colors.white,
        body:  Center(
          child: LoadingBouncingLine.circle(),
        )
      );
    }
    List<Widget> lists = [];
    lists.add(
      CustomPaint(
        painter: ProgressCircle(
          width: MediaQuery.of(context).size.width,
          height: 200
        ),
        child: Container(
          width: double.infinity,
          height: 200
        ),
      )
    );
    if (detail.currentStatus == 'nosign') {
      lists.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoButton(
              child: Text('去签到'),
              onPressed: (){
                Navigator.of(context).pushNamed('/checktask', arguments: detail.taskId).then((value) => {
                  if (value == true) {
                    _reload()
                  }
                });
              },
              color: Colors.blue,
              pressedOpacity: .5,
            )
          ],
        )
      );
    } else {
      lists.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '已签到'
            )
          ],
        )
      );
    }
    
    lists.add(
      new Container(
        child: new Column(
          children: <Widget>[
            Container(
              child: new TaskDetail1(
                taskId: detail.taskId,
                title: detail.title,
                currentDay: detail.currentDay,
                target: detail.target,
                dateCreated: detail.dateCreated,
                allDays: detail.allDays,
                holidayDays: detail.holidayDays,
                dayofftaken: detail.dayofftaken,
                isfine: detail.isfine,
                fine: detail.fine,
                supervisor: detail.supervisor,
                logs: detail.logs,
                status: detail.status,
                lastUpdate: detail.lastUpdate,
                tagColor: ColorsUtil.hexStringColor(detail.tagInfo.color),
                tagInfo: detail.tagInfo,
                reward: detail.reward,
                punishment: detail.punishment,
                reload: () {
                  _reload();
                }
              )
            ),
          ],
        )
      )
    );

    detail.logs.forEach((item) {
      lists.add(
        CheckLog(
          checkTime: item.checkTime,
          remark: item.remark,
          type: item.type
        )
      );
    });
    return new Scaffold(
        appBar: new AppBar(
          leading: GestureDetector(child: Icon(Icons.arrow_back_ios),onTap: (){
            Navigator.pop(context, _change);
          }),
          title: Text('目标详情')
        ),
        backgroundColor: Colors.white,
        body: Container(
          child: new ListView(
            children: lists
          ),
        ) 
      );
  }
}
