import 'package:flutter/material.dart';
import 'package:flutter/Cupertino.dart';

import '../editItem/index.dart';

import '../../utils/request/index.dart';
import '../../utils/colorsUtil.dart';
import '../../types/index.dart';
import '../../config.dart';

class TaskDetail1 extends StatefulWidget {
  TaskDetail1(
      {Key key,
      this.taskId,
      this.title,
      this.target,
      this.dateCreated,
      this.allDays,
      this.holidayDays,
      this.dayofftaken,
      this.isfine,
      this.fine,
      this.supervisor,
      this.logs,
      this.status,
      this.lastUpdate,
      this.reload,
      this.tagColor,
      this.currentDay,
      this.tagInfo,
      this.punishment,
      this.reward  
    })
      : super(key: key);

  final int taskId;
  final String title;
  final String target;
  final String dateCreated;
  final int allDays;
  final int holidayDays;
  final int dayofftaken;
  final bool isfine;
  final double fine;
  final TypesSupervisor supervisor;
  final List<TypesLog> logs;
  final String status;
  final String lastUpdate;
  final int currentDay;
  final String punishment;
  final String reward;

  final Color tagColor;
  final Tag tagInfo;

  final reload;

  @override
  _TaskDetail createState() => _TaskDetail();
}

class _TaskDetail extends State<TaskDetail1> {
  bool _editTitle = false;

  bool _editTarget = false;

  String _editTitleText = '';

  String _editTargetText = '';

  @override
  void initState() {
    super.initState();
    _editTitleText = widget.title;
    _editTargetText = widget.target;
  }

  _updateTask(String _key, String _value) async {
    final key = _key;
    final value = _value;
    final params = {key: value, 'taskId': widget.taskId};
    final result =
        await Request.post(Urls.env + '/task/edit', params);
    if (result != null && result['success'] == true) {
      widget.reload();
    } else {
      print('失败了');
    }
  }

  @override
  Widget build(BuildContext context) {
    String tagName = widget?.tagInfo?.name;
    String tagColor = widget?.tagInfo?.color;
    return new Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                  padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        height: 80,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                Column(
                                  children: <Widget> [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Baseline(
                                          baseline: 30,
                                          baselineType: TextBaseline.alphabetic,
                                          child: Text(
                                            '第',
                                            style: TextStyle(
                                              textBaseline: TextBaseline.alphabetic,
                                            ),
                                          )
                                        ),
                                        Baseline(
                                          baseline: 30,
                                          baselineType: TextBaseline.alphabetic,
                                          child: Text(
                                            widget.currentDay.toString(),
                                            style: TextStyle(
                                              color: widget.tagColor,
                                              fontSize: 30,
                                              textBaseline: TextBaseline.alphabetic,
                                            ),
                                          )
                                        ),
                                        Baseline(
                                          baseline: 30,
                                          baselineType: TextBaseline.alphabetic,
                                          child: Text(
                                            '天',
                                            style: TextStyle(
                                              textBaseline: TextBaseline.alphabetic,
                                            ),
                                          )
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Baseline(
                                          baseline: 30,
                                          baselineType: TextBaseline.alphabetic,
                                          child: Text(
                                            '总计',
                                            style: TextStyle(
                                              textBaseline: TextBaseline.alphabetic,
                                            ),
                                          )
                                        ),
                                        Baseline(
                                          baseline: 30,
                                          baselineType: TextBaseline.alphabetic,
                                          child: Text(
                                            widget.allDays.toString(),
                                            style: TextStyle(
                                              color: widget.tagColor,
                                              fontSize: 30,
                                              textBaseline: TextBaseline.alphabetic,
                                            ),
                                          )
                                        ),
                                        Baseline(
                                          baseline: 30,
                                          baselineType: TextBaseline.alphabetic,
                                          child: Text(
                                            '天',
                                            style: TextStyle(
                                              textBaseline: TextBaseline.alphabetic,
                                            ),
                                          )
                                        ),
                                      ],
                                    )
                                  ]
                                )
                            ],
                          ),
                        )
                      ),
                      Container(
                        height: 60,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('剩余假期' + (widget.holidayDays - widget.dayofftaken).toString())
                                ]
                              )
                            ],
                          ),
                        )
                      ),
                      Container(
                        height: 60,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('¥ ' + widget.fine.toString()),
                                  Text('挑战金')
                                ]
                              )
                            ],
                          ),
                        )
                      ),
                      Container(
                        height: 60,
                        child: Center(
                          child: Offstage(
                            offstage: tagName == null,
                            child: Container(
                                padding: EdgeInsets.fromLTRB(3, 1, 3, 1),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: tagColor != null
                                      ? ColorsUtil.hexStringColor(tagColor)
                                      : Colors.white,
                                ),
                                child: Text(tagName == null ? '' : tagName,
                                    style: TextStyle(color: Colors.white))),
                          ),
                        ),
                      )
                    ],
                  )),
            )
          ],
        ),
        Container(
          padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
          child: Column(
            children: <Widget>[
              EditItem(
                label: '目标',
                value: widget.title,
                taskId: widget.taskId,
                valueKey: 'title',
                callback: () => {
                  widget.reload()
                }
              ),
              EditItem(
                label: '目的',
                value: widget.target,
                taskId: widget.taskId,
                valueKey: 'target',
                callback: () => {
                  widget.reload()
                }
              ),
              EditItem(
                label: '达成奖励',
                value: widget.reward,
                taskId: widget.taskId,
                valueKey: 'reward',
                callback: () => {
                  widget.reload()
                }
              ),
              EditItem(
                label: '未达成惩罚',
                value: widget.punishment,
                taskId: widget.taskId,
                valueKey: 'punishment',
                callback: () => {
                  widget.reload()
                }
              )
            ],
          ),
        )
      ],
    );
  }
}
