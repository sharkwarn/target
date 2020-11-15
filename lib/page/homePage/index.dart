import 'package:flutter/material.dart';
import 'package:flutter/Cupertino.dart';
import 'package:provider/provider.dart';
import '../../components/tapBox/index.dart';
import '../../components/listTaskItem/index.dart';
import '../../components/rewardList/index.dart';
import '../search/index.dart';
import '../../types/index.dart';
import '../../components/pageAnimation/index.dart';
import '../../components/selectTags/index.dart';
import '../../utils/request/index.dart';
import '../../config.dart';

import '../../modal/login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TypesTask> _tasks = [];

  List<dynamic> rewardList = [];

  int tagId;

  String currentStatus = 'nosign';

  String status = 'ongoing';

  @override
  initState() {
    super.initState();
    _getList();
  }

  _getList() async {
    if (status == 'reward') {
      getRewardList();
      return;
    }
    final Map<String, dynamic> params = {
      'tag': tagId
    };
    if (currentStatus == null) {
      params['status'] = status;
      params['orders'] = [
        ['lastUpdate', 'desc']
      ];
    } else {
      params['currentStatus'] = currentStatus;
      params['status'] = ['ongoing', 'willStart'];
    }
    final result = await Request.post(Urls.env + '/task/getList', params);
    if (result != null && result['success'] == true) {
      final lists = result['data'].map<TypesTask>((item) => TypesTask.fromMap(item)).toList();
      setState(() {
        _tasks = lists;
      });
    }
    
  }

  getRewardList() async {
    final Map<String, dynamic> params = {
      'tagId': tagId
    };
    final result = await Request.post(Urls.env + '/task/rewardList', params);
    if (result != null && result['success'] == true) {
      final lists = result['data'];
      setState(() {
        rewardList = lists;
      });
    }
  }

  getCounterList() async {
  }

  _showTags() {
    Navigator.push(context, SlideTopRoute(page: SelectTags())).then((value) {
      if (value == '全部') {
        setState(() {
          tagId = null;
        });
        _getList();
      } else if (value != null) {
        setState(() {
          tagId = value.tagId;
        });
        _getList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> lists = _tasks.map((item) {
      final int taskId = item.taskId;
      final String title = item.title;
      final int allDays = item.allDays;
      final int holidayDays = item.holidayDays;
      final int dayofftaken = item.dayofftaken;
      final Tag tagInfo = item.tagInfo;
      final String currentStatus = item.currentStatus;
      final String status = item.status;
      final int haveSignDays = item.haveSignDays;
      final int preAllDays = item.preAllDays ?? 0;
      return new ListTaskItem(
          taskId: taskId,
          title: title,
          allDays: allDays + preAllDays,
          holidayDays: holidayDays,
          dayofftaken: dayofftaken == null ? 0 : dayofftaken,
          tagInfo: tagInfo,
          currentStatus: currentStatus,
          status: status,
          currentDay: haveSignDays,
          completedDay: haveSignDays,
          reload: () {
            _getList();
          },
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
            title: new Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Row(
              children: <Widget>[
                new IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                        context: context, delegate: CustomSearchDelegate());
                  },
                ),
                new Text('|'),
                new IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/create').then((value) => {
                          if (value == 'create') {_getList()}
                        });
                  },
                )
              ],
            )
          ],
        )),
        body: new Column(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(10, 4, 10, 4),
                  child: Row(
                    children: [
                      TapBox(
                        onTap: () {
                          setState(() {
                            currentStatus = 'nosign';
                            status = null;
                          });
                          _getList();
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          decoration: new BoxDecoration(
                            color: currentStatus == 'nosign' ? Colors.blue : Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          ),
                          child: Text(
                            '未签到',
                            style: TextStyle(
                              color: currentStatus == 'nosign' ? Colors.white : Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      TapBox(
                        onTap: () {
                          setState(() {
                            currentStatus = 'done';
                            status = null;
                          });
                          _getList();
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          decoration: new BoxDecoration(
                            color: currentStatus == 'done' ? Colors.blue : Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          ),
                          child: Text(
                            '已签到',
                            style: TextStyle(
                              color: currentStatus == 'done' ? Colors.white : Colors.blue,
                            ),
                          ),
                        )
                      ),
                      TapBox(
                        onTap: () {
                          setState(() {
                            status = 'success';
                            currentStatus = null;
                          });
                          _getList();
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          decoration: new BoxDecoration(
                            color: status == 'success' ? Colors.blue : Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          ),
                          child: Text(
                            '已完成',
                            style: TextStyle(
                              color: status == 'success' ? Colors.white : Colors.blue,
                            ),
                          ),
                        )
                      ),
                      TapBox(
                        onTap: () {
                          setState(() {
                            status = 'fail';
                            currentStatus = null;
                          });
                          _getList();
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          decoration: new BoxDecoration(
                            color: status == 'fail' ? Colors.blue : Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          ),
                          child: Text(
                            '已失败',
                            style: TextStyle(
                              color: status == 'fail' ? Colors.white : Colors.blue,
                            ),
                          ),
                        )
                      ),
                      TapBox(
                        onTap: () {
                          setState(() {
                            status = 'reward';
                            currentStatus = null;
                          });
                          _getList();
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                          margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          decoration: new BoxDecoration(
                            color: status == 'reward' ? Colors.blue : Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          ),
                          child: Text(
                            '赏罚表',
                            style: TextStyle(
                              color: status == 'reward' ? Colors.white : Colors.blue,
                            ),
                          ),
                        )
                      )
                    ],
                  ),
                ),
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
                child: RefreshIndicator(
                  onRefresh: () async {
                    _getList();
                  },
                  child: status != 'reward' ? new ListView(
                    padding: const EdgeInsets.all(8),
                    children: lists.length > 0 ? lists : [
                      Center(child: Text('没有数据'),)
                    ],
                  ) : RewardListCom(
                    reward: rewardList,
                    reload: () {
                      getRewardList();
                    },
                  )
                ),
              ),
            )
          ],
        ),
        drawer: Drawer(
          child: Container(
          padding: EdgeInsets.fromLTRB(0, 40, 0, 40),
          child: ListView(
            children: <Widget>[
              TapBox(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed('/rewardList');
                },
                child: Container(
                  child: Card(
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(8, 6, 8, 6),
                          child: Row(
                            children: <Widget>[Icon(Icons.history), Text('赏罚列表')],
                          )
                        )
                      ],
                    ),
                  ),
                ),
              ),
              TapBox(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed('/tagsManage');
                  // .then((value) => {
                  //   if (value == 'create') {
                  //     _getList()
                  //   }
                  // });
                },
                child: Container(
                  child: Card(
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(8, 6, 8, 6),
                          child: Row(
                            children: <Widget>[Icon(Icons.menu), Text('标签管理')],
                          )
                        )
                      ],
                    ),
                  ),
                ),
              ),
              TapBox(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed('/history');
                },
                child: Container(
                  child: Card(
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(8, 6, 8, 6),
                          child: Row(
                            children: <Widget>[Icon(Icons.history), Text('历史任务')],
                          )
                        )
                      ],
                    ),
                  ),
                ),
              ),
              TapBox(
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      return CupertinoAlertDialog(
                        title: Text('提示'),
                        content:Text('是否确定退出登录？'),
                        actions:<Widget>[
                          CupertinoDialogAction(
                            child: Text('是'),
                            onPressed: (){
                              Navigator.of(context).pop();
                              Request.clearToken();
                              Provider.of<LoginModal>(context, listen: false).changeStatus(false);
                            },
                          ),
                      
                          CupertinoDialogAction(
                            child: Text('否'),
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  child: Card(
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(8, 6, 8, 6),
                          child: Row(
                            children: <Widget>[Icon(Icons.exit_to_app), Text('退出登录')],
                          )
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )));
  }
}
