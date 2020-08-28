import 'package:flutter/material.dart';
import 'package:flutter/Cupertino.dart';
import 'package:flutter_app2/globalData/index.dart';
import '../progress/index.dart';

import '../../utils/colorsUtil.dart';
import '../../types/index.dart';

class TaskDetail1 extends StatefulWidget {
  TaskDetail1({
    Key key,
    this.id,
    this.title,
    this.target,
    this.dateCreated,
    this.allDays,
    this.holidayDays,
    this.dayofftaken,
    this.isfine,
    this.fine,
    this.supervisor,
    this.checklogs,
    this.status,
    this.lastUpdate,
    this.reload,
    this.tagColor,
    this.tagInfo
  }) : super(
    key: key
  );

  final int id;
  final String title;
  final String target;
  final String dateCreated;
  final int allDays;
  final int holidayDays;
  final int dayofftaken;
  final bool isfine;
  final double fine;
  final TypesSupervisor supervisor;
  final List<TypesCheckLog> checklogs;
  final String status;
  final String lastUpdate;

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

  _updateTask (String _key, String _value) async {
    final key = _key;
    final value = _value;
    final params = {
      key: value
    };
    final res = await GlobalData.update(widget.id, params);
    if (res == true) {
      widget.reload();
    }
  }

  @override
  Widget build(BuildContext context) {
    String tagName = widget?.tagInfo?.name;
    String tagColor = widget?.tagInfo?.color;
    return new Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
          child: Column(
            children: <Widget>[
              Offstage(
                offstage: _editTitle,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Text(widget.title),
                    ),
                    Container(
                      child: CupertinoButton(
                        onPressed: () {
                          setState(() {
                            _editTitle = true;
                          });
                        },
                        child: Text('编辑'),
                      ),
                    )
                ],),
              ),
              Offstage(
                offstage: !_editTitle,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 30,
                        constraints: BoxConstraints(maxWidth: 160),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          autofocus: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none
                            ),
                          ),
                          onChanged: (value) {
                            this._editTitleText = value;
                          },
                          controller: TextEditingController.fromValue(TextEditingValue(
                            text: '${this._editTitleText == null ? "" : this._editTitleText}',  //判断keyword是否为空
                            // 保持光标在最后
                            selection: TextSelection.fromPosition(TextPosition(
                                affinity: TextAffinity.downstream,
                                offset: '${this._editTitleText}'.length))
                            )
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: CupertinoButton(
                        onPressed: () {
                          setState(() {
                            _editTitle = false;
                            _updateTask('title', _editTitleText);
                          });
                        },
                        child: Text('保存'),
                      )
                    )
                ],),
              ),
              Offstage(
                offstage: _editTarget,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Text('目标动机：' + widget.target),
                    ),
                    Container(
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          setState(() {
                            _editTarget = true;
                          });
                        },
                      )
                    )
                ],),
              ),
              Offstage(
                offstage: !_editTarget,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 30,
                        constraints: BoxConstraints(maxWidth: 160),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          autofocus: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none),
                          ),
                          onChanged: (value) {
                            this._editTargetText = value;
                          },
                          controller: TextEditingController.fromValue(TextEditingValue(
                            text: '${this._editTargetText == null ? "" : this._editTargetText}',  //判断keyword是否为空
                            // 保持光标在最后
                            selection: TextSelection.fromPosition(TextPosition(
                                affinity: TextAffinity.downstream,
                                offset: '${this._editTargetText}'.length))
                            )
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: IconButton(
                        icon: Icon(Icons.save),
                        onPressed: () {
                          setState(() {
                            _editTarget = false;
                            _updateTask('target', _editTargetText);
                          });
                        },
                      )
                    )
                ],),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            height: 60,
                            child: Center(
                              child: Row(
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
                                      widget.checklogs.length.toString(),
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
                                    color: tagColor != null ? ColorsUtil.hexStringColor(tagColor) : Colors.white,
                                  ),
                                  child: Text(
                                    tagName == null ? '' : tagName,
                                    style: TextStyle(
                                      color: Colors.white
                                    )
                                  )
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
                      child: CircleProgressWidget(
                        progress: Progress(
                          backgroundColor: Colors.grey,
                          value: widget.checklogs.length / widget.allDays,
                          radius: MediaQuery.of(context).size.width * 0.20,
                          completeText: "完成",
                          color: Color(0xff46bcf6),
                          strokeWidth: 4
                        )
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}