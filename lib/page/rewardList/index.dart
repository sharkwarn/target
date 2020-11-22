import 'package:flutter/material.dart';
import 'package:flutter/Cupertino.dart';
import '../../components/tapBox/index.dart';
import '../../utils/colorsUtil.dart';
import '../../components/pageAnimation/index.dart';
import '../../components/selectTags/index.dart';
import '../../utils/request/index.dart';
import '../../config.dart';

class RewardList extends StatefulWidget {
  @override
  _RewardList createState() => new _RewardList();
}

class _RewardList extends State<RewardList> {
  List<dynamic> reward = [];

  int tagId;

  String currentStatus = 'nosign';

  String status = 'ongoing';

  @override
  initState() {
    super.initState();
    _getList();
  }

  _getList() async {
    print(tagId);
    final Map<String, dynamic> params = {
      'tagId': tagId
    };
    final result = await Request.post(Urls.env + '/task/rewardList', params);
    if (result != null && result['success'] == true) {
      final lists = result['data'];
      setState(() {
        reward = lists;
      });
    }
  }

  _edit(int taskId, int rewardstatus) async {
    final result = await Request.post(Urls.env + '/task/editReward', {
      'taskId': taskId,
      'rewardstatus': rewardstatus
    });
    if (result != null && result['success'] == true) {
      _getList();
    }
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
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('赏罚列表')
        ),
        body: new Column(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(10, 4, 10, 4),
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
                        color: Theme.of(context).primaryColor
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
                  child: new ListView.builder(
                    itemCount: reward.length,
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (BuildContext context,int index){
                      final detail = reward[index];
                      final String title = detail['title'];
                      final String tagName = detail['tagName'];
                      final String tagColor = detail['tagColor'];
                      final int rewardstatus = detail['rewardstatus'];
                      final String rewardItem = detail['reward'];
                      final String punishment = detail['punishment'];
                      final int taskId = detail['taskId'];
                      return Card(
                        elevation: 10,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
                        color: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    title,
                                    style: new TextStyle(
                                      fontSize: 18.0,
                                      color: ColorsUtil.hexStringColor(tagColor),
                                    ),
                                  ),
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
                                ],
                              ),
                              Container(
                                color: ColorsUtil.hexStringColor(tagColor),
                                height: 1,
                                margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 1, 5, 0),
                                    child: Text(
                                      '奖励:',
                                      style: TextStyle(
                                        height: 1.5
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Wrap(
                                      children: [
                                        Text(
                                          rewardItem,
                                          style: TextStyle(
                                            height: 1.5
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(5, 2, 0, 0),
                                    child: Row(
                                      children: [
                                        TapBox(
                                          onTap: () {
                                            _edit(taskId, 1);
                                          },
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            margin: EdgeInsets.fromLTRB(0, 0, 3, 0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: rewardstatus == 1 || rewardstatus == null ? Theme.of(context).primaryColor : Colors.grey,
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Y',
                                                style: TextStyle(
                                                  color: Colors.white
                                                ),
                                              ),
                                            )
                                          ),
                                        ),
                                        TapBox(
                                          onTap: () {
                                            _edit(taskId, 2);
                                          },
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            margin: EdgeInsets.fromLTRB(3, 0, 0, 0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: rewardstatus == 2 || rewardstatus == null ? Colors.red : Colors.grey,
                                            ),
                                            child: Center(
                                              child: Text(
                                                'N',
                                                style: TextStyle(
                                                  color: Colors.white
                                                ),
                                              ),
                                            )
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                height: 1,
                                margin: EdgeInsets.fromLTRB(0, 4, 0, 4),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 1, 5, 0),
                                    child: Text(
                                      '惩罚:',
                                      style: TextStyle(
                                        height: 1.5
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Wrap(
                                      children: [
                                        Text(
                                          punishment,
                                          style: TextStyle(
                                            height: 1.5
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(5, 1, 0, 0),
                                    child: Row(
                                      children: [
                                        TapBox(
                                          onTap: () {
                                            _edit(taskId, 3);
                                          },
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            margin: EdgeInsets.fromLTRB(0, 0, 3, 0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: rewardstatus == 3 || rewardstatus == null ? Theme.of(context).primaryColor : Colors.grey,
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Y',
                                                style: TextStyle(
                                                  color: Colors.white
                                                ),
                                              ),
                                            )
                                          ),
                                        ),
                                        TapBox(
                                          onTap: () {
                                            _edit(taskId, 4);
                                          },
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            margin: EdgeInsets.fromLTRB(3, 0, 0, 0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: rewardstatus == 4 || rewardstatus == null ? Colors.red : Colors.grey,
                                            ),
                                            child: Center(
                                              child: Text(
                                                'N',
                                                style: TextStyle(
                                                  color: Colors.white
                                                ),
                                              ),
                                            )
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ),
              ),
            )
          ],
        ),
    );
  }
}
