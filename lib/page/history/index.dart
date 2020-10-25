import 'package:flutter/material.dart';
import 'package:flutter/Cupertino.dart';
import '../../components/tapBox/index.dart';
import '../../components/listTaskItem/index.dart';
import '../../types/index.dart';
import '../../components/pageAnimation/index.dart';
import '../../components/selectTags/index.dart';
import '../../utils/request/index.dart';
import '../../config.dart';

class History extends StatefulWidget {
  @override
  _History createState() => new _History();
}

class _History extends State<History> {
  List<TypesTask> _tasks = [];

  @override
  initState() {
    super.initState();
    _getList();
  }

  _getList() async {
    final result = await Request.post(Urls.env + '/task/getList', {
      'status': [
        'success', 'fail'
      ]
    });
    if (result != null && result['success'] == true) {
      final lists = result['data'].map<TypesTask>((item) => TypesTask.fromMap(item)).toList();
      setState(() {
        _tasks = lists;
      });
    }
  }

  _showTags() {
    Navigator.push(context, SlideTopRoute(page: SelectTags())).then((value) {
      if (value == '全部') {
        _getList();
      } else if (value != null) {
        _fetchData(value.tagId);
      }
    });
  }

  Future _fetchData(int tagId) async {
    final result = await Request.post(Urls.env + '/task/getList', {
      'tag': tagId,
      'orders': [
        ['lastUpdate', 'desc']
      ],
      'status': [
        'success', 'fail'
      ]
    });
    if (result != null && result['success'] == true) {
      final lists = result['data'].map<TypesTask>((item) => TypesTask.fromMap(item)).toList();
      setState(() {
        _tasks = lists;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> lists = _tasks.map((item) {
      final String title = item.title;
      final int allDays = item.allDays;
      final int holidayDays = item.holidayDays;
      final int dayofftaken = item.dayofftaken;
      final int taskId = item.taskId;
      final Tag tagInfo = item.tagInfo;
      final String currentStatus = item.currentStatus;
      final String status = item.status;
      final int haveSignDays = item.haveSignDays;
      final int preAllDays = item.preAllDays ?? 0;
      return new ListTaskItem(
          title: title,
          allDays: allDays + preAllDays,
          holidayDays: holidayDays,
          dayofftaken: dayofftaken == null ? 0 : dayofftaken,
          tagInfo: tagInfo,
          currentStatus: currentStatus,
          status: status,
          completedDay: haveSignDays,
          onTap: () {
            Navigator.of(context)
                .pushNamed('/detail', arguments: taskId)
                .then((value) => {
                      if (value) {_getList()}
                    });
          });
    }).toList();
    return new Scaffold(
      appBar: new AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(''),
            Text('历史任务'),
            Container(
              height: 20,
              width: 50,
            )
          ],
        )
      ),
      body: new Column(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(''),
              TapBox(
                onTap:  () {
                  _showTags();
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 4, 16, 4),
                  child: new Text(
                    '筛选',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue
                    )
                  )
                ),
              )
            ]
          ),
          new Expanded(
            flex: 1,
            child: new Container(
              child: new ListView(
                padding: const EdgeInsets.all(8),
                children: lists.length > 0 ? lists : [
                  Center(child: Text('没有数据'),)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
