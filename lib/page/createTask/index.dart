
/// 这是一个有状态组件，有状态组件必须由两部分构成。StatefulWidget 和 State

import 'package:flutter/material.dart';
import 'package:flutter/Cupertino.dart';
import 'package:flutter/services.dart';
import '../../components/tapBox/index.dart';
import '../../components/pageAnimation/index.dart';
import '../../components/selectTags/index.dart';
import '../../utils/colorsUtil.dart';

import '../../utils/request/index.dart';
import '../../config.dart';

class CreateTask extends StatefulWidget {
  _CreateTask createState() => new _CreateTask();
}

class _CreateTask extends State<CreateTask> {

  int taskId;

  String title;

  String target;

  int allDays;

  // 可休假
  int holidayDays;

  // 罚金金额
  double fine;

  // 标签ID
  int tag;

  // 明天开始
  bool willStart = false;

  // 计数功能
  bool counter = false;

  // 标签文本
  String tagText;

  // 标签颜色
  String tagColor;

  // 奖励
  String reward;

  // 惩罚
  String punishment;

  // 展示
  bool show = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Map arguments = ModalRoute.of(context).settings.arguments;
      setState(() {
        if (arguments != null) {
          taskId = arguments['taskId'] ?? '';
          title = arguments['title'] ?? '';
          target = arguments['target'] ?? '';
          allDays = arguments['allDays'] ?? '';
          holidayDays = arguments['holidayDays'] ?? '';
          fine = arguments['fine'] ?? '';
          tag = arguments['tag'];
          tagText = arguments['tagName'];
          tagColor = arguments['tagColor'];
          reward = arguments['reward'] ?? '';
          punishment = arguments['punishment'] ?? '';
          counter = arguments['counter'] == 1 ? true : false;
        }
        show = true;
      });
    });
  }

  bool checkForm() {
    if (title != null && allDays != null && holidayDays != null && fine != null && tag != null) {
      return true;
    }
    return false;
  }

  final _formKey = GlobalKey<FormState>();

  _submit() async {
    String url = taskId != null ? '/task/restart' : '/task/create';
    final res = await Request.post(Urls.env + url, {
      'taskId': taskId,
      'title': title,
      'target': target,
      'allDays': allDays,
      'holidayDays': holidayDays,
      'fine': fine,
      'tag': tag,
      'reward': reward,
      'punishment': punishment,
      'willStart': willStart,
      'counter': counter ? 1 : 0
    });
    if (res != null && res['success'] == true) {
      Navigator.pop(context, 'create');
    }
  }

  _showTags() {
    Navigator.push(context, SlideTopRoute(page: SelectTags(hiddenAll: true))).then((value) {
      if (value != null) {
        setState(() {
          tag = value.tagId;
          tagText = value.name;
          tagColor = value.color;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    double itemHeight = 50;
    final TextStyle fontStyle = TextStyle(
      fontSize: 16,
      color: Colors.black
    );
    final TextStyle requireFontStyle = TextStyle(
      fontSize: 16,
      color: Colors.red
    );
    FocusNode blankNode = FocusNode();
    Widget body = Container();
    if (show == true) {
      body = new Container(
        child: new Column(
          children: <Widget>[
            new Expanded(
              flex: 1,
              child: new Container(
                child: new ListView(
                  padding: const EdgeInsets.all(0),
                  children: <Widget>[
                    new Container(
                      padding: EdgeInsets.fromLTRB(12, 0, 8, 0),
                      color: Colors.white,
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).requestFocus(blankNode);
                        },
                        child: new Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: itemHeight,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: Color(0xffe5e5e5)
                                    )
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 100,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                                        child: Row(
                                          children: [
                                            Text(
                                              '*',
                                              style: requireFontStyle,
                                              
                                            ),
                                            Text(
                                              '目标',
                                              style: fontStyle,
                                            )
                                          ],
                                        ),
                                      )
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            hintText: '请输入目标名称',
                                            border: InputBorder.none,
                                          ),
                                          initialValue: title,
                                          onSaved: (val) {
                                            title = val;
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ),
                              Container(
                                height: itemHeight,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: Color(0xffe5e5e5)
                                    )
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 100,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                                        child: Row(
                                          children: [
                                            Text(
                                              '*',
                                              style: requireFontStyle,
                                            ),
                                            Text(
                                              '天数',
                                              style: fontStyle,
                                            )
                                          ],
                                        )
                                      )
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                                        child: TextFormField(
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                                          ],
                                          keyboardType: TextInputType.number,
                                          initialValue: (allDays ?? '').toString(),
                                          decoration: const InputDecoration(
                                            hintText: '请输入周期天数，如7，14，28等',
                                            border: InputBorder.none,
                                          ),
                                          // validator: (value) {
                                          //   if (value.isEmpty) {
                                          //     return '请输入完成天数';
                                          //   }
                                          //   return null;
                                          // },
                                          onSaved: (val) {
                                            allDays = int.parse(val);
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ),
                              Container(
                                height: itemHeight,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: Color(0xffe5e5e5)
                                    )
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 100,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                                        child: Row(
                                          children: [
                                            Text(
                                              '*',
                                              style: requireFontStyle,
                                            ),
                                            Text(
                                              '休假天数',
                                              style: fontStyle,
                                            )
                                          ],
                                        ),
                                      )
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                                        child: TextFormField(
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
                                          ],
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            hintText: '希望休假天数',
                                            border: InputBorder.none,
                                          ),
                                          // validator: (value) {
                                          //   if (value.isEmpty) {
                                          //     return '请输入休假天数';
                                          //   }
                                          //   return null;
                                          // },
                                          initialValue: (holidayDays ?? '').toString(),
                                          onSaved: (val) {
                                            holidayDays = int.parse(val);
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ),
                              Container(
                                height: itemHeight,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: Color(0xffe5e5e5)
                                    )
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 100,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                                        child: Row(
                                          children: [
                                            Text(
                                              '*',
                                              style: requireFontStyle,
                                            ),
                                            Text(
                                              '押金',
                                              style: fontStyle,
                                            )
                                          ],
                                        ),
                                      )
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                                        child: TextFormField(
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
                                          ],
                                          keyboardType:  TextInputType.numberWithOptions(decimal: true),
                                          decoration: const InputDecoration(
                                            hintText: '金额',
                                            border: InputBorder.none,
                                          ),
                                          // validator: (value) {
                                          //   if (value.isEmpty) {
                                          //     return '请输入金额';
                                          //   }
                                          //   return null;
                                          // },
                                          initialValue: (fine ?? '').toString(),
                                          onSaved: (val) {
                                            fine = double.parse(val);
                                          },
                                        )
                                      ),
                                    )
                                  ],
                                )
                              ),
                              Container(
                                height: itemHeight,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: Color(0xffe5e5e5)
                                    )
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 100,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                                        child: Row(
                                          children: [
                                            Text(
                                              '*',
                                              style: requireFontStyle,
                                            ),
                                            Text(
                                              '所属分类',
                                              style: fontStyle,
                                            )
                                          ],
                                        )
                                      )
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: TapBox(
                                        onTap: () {
                                          FocusScope.of(context).requestFocus(blankNode);
                                          _showTags();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                decoration: new BoxDecoration(
                                                  color: tagColor != null ? ColorsUtil.hexStringColor(tagColor) : null,
                                                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                    tagText != null ? 8 : 0,
                                                    3, 8, 3
                                                  ),
                                                  child: Text(
                                                    tagText != null ? tagText :'选择标签',
                                                    style: TextStyle(
                                                      color: tagColor != null ? Colors.white : Colors.grey,
                                                      fontSize: 16
                                                    )
                                                  )
                                                )
                                              )
                                            ],
                                          )
                                        ),
                                      )
                                    )
                                  ],
                                )
                              ),
                              Container(
                                height: itemHeight,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: Color(0xffe5e5e5)
                                    )
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 100,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                                        child: Text(
                                          ' 明天开始',
                                          style: fontStyle,
                                        ),
                                      )
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            CupertinoSwitch(
                                              value: willStart,
                                              onChanged: (onOff) {
                                                setState(() {
                                                  willStart = onOff;
                                                });
                                              },
                                              activeColor: Colors.green,
                                            )
                                          ],
                                        )
                                      ),
                                    )
                                  ],
                                )
                              ),
                              Container(
                                height: itemHeight,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: Color(0xffe5e5e5)
                                    )
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 100,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                                        child: Text(
                                          '开启计数',
                                          style: fontStyle,
                                        ),
                                      )
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            CupertinoSwitch(
                                              value: counter,
                                              onChanged: (onOff) {
                                                setState(() {
                                                  counter = onOff;
                                                });
                                              },
                                              activeColor: Colors.green,
                                            )
                                          ],
                                        )
                                      ),
                                    )
                                  ],
                                )
                              ),
                              Container(
                                height: itemHeight,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: Color(0xffe5e5e5)
                                    )
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 100,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                                        child: Text(
                                          ' 目的',
                                          style: fontStyle,
                                        ),
                                      )
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            hintText: '请输入目的',
                                            border: InputBorder.none,
                                          ),
                                          // validator: (value) {
                                          //   if (value.isEmpty) {
                                          //     return '请输入目的';
                                          //   }
                                          //   return null;
                                          // },
                                          initialValue: target,
                                          onSaved: (val) {
                                            target = val;
                                          },
                                        )
                                      ),
                                    )
                                  ],
                                )
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: Color(0xffe5e5e5)
                                    )
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 100,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                                        child: Text(
                                          ' 达成奖励',
                                          strutStyle: StrutStyle(height: 2.6),
                                          style: fontStyle,
                                        ),
                                      )
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                                        child: TextFormField(
                                          maxLines: 3,
                                          decoration: const InputDecoration(
                                            hintText: '请输入奖励',
                                            border: InputBorder.none,
                                          ),
                                          // validator: (value) {
                                          //   if (value.isEmpty) {
                                          //     return '请输入目的';
                                          //   }
                                          //   return null;
                                          // },
                                          initialValue: reward,
                                          onSaved: (val) {
                                            reward = val;
                                          },
                                        )
                                      ),
                                    )
                                  ],
                                )
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: Color(0xffe5e5e5)
                                    )
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 100,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                                        child: Text(
                                          ' 未达成惩罚',
                                          strutStyle: StrutStyle(height: 2.6),
                                          style: fontStyle,
                                        ),
                                      )
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                                        child: TextFormField(
                                          maxLines: 3,
                                          decoration: const InputDecoration(
                                            hintText: '请输入惩罚',
                                            border: InputBorder.none,
                                          ),
                                          // validator: (value) {
                                          //   if (value.isEmpty) {
                                          //     return '请输入目的';
                                          //   }
                                          //   return null;
                                          // },
                                          initialValue: punishment,
                                          onSaved: (val) {
                                            punishment = val;
                                          },
                                        )
                                      ),
                                    )
                                  ],
                                )
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    new Container(
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                      margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: new Container(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                        color: Colors.white,
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                              color: Theme.of(context).primaryColor,
                              child: new Row(
                                children: <Widget>[
                                  new Icon(
                                    Icons.warning,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  new Text('请了解详细规则!')
                                ]
                              )
                            ),
                            new Row(
                              children: <Widget>[
                                new Container(
                                    margin: EdgeInsets.fromLTRB(0, 8, 0, 8),
                                    child: new Text(
                                    '注意事项:',
                                    textAlign: TextAlign.left,
                                    style: new TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600
                                    )
                                  )
                                )
                              ],
                            ),
                            new Container(
                              width: double.infinity,
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                              child: new Text(
                                '任务一旦开始后不可以结束.\n每天的签到时间是24:00之前，24:00之后会进行结算，\n任务完成后，押金将会从原来的支付方式返回。',
                                textAlign: TextAlign.left,
                                style: new TextStyle(
                                  fontSize: 12,
                                )
                              )
                            )
                          ]
                        )
                      )
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              child: new CupertinoButton(
                minSize: double.infinity,
                child: Text("保存",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Theme.of(context).primaryColor,
                onPressed: (){
                  _formKey.currentState.save();
                  if (checkForm()) {
                    // Process data.
                    _submit();               
                  }
                },
                pressedOpacity: 0.7,
              )
            )
          ]
        ),
      );
    }
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('创建目标')
        ),
        backgroundColor: Colors.grey[300],
        body: body
      );
  }
}
