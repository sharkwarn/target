
/// 这是一个有状态组件，有状态组件必须由两部分构成。StatefulWidget 和 State

import 'package:flutter/material.dart';
import 'package:flutter/Cupertino.dart';
import 'package:flutter/services.dart';
import '../../components/tapBox/index.dart';
import '../../components/pageAnimation/index.dart';
import '../../components/selectTags/index.dart';
import '../../utils/colorsUtil.dart';

import '../../utils/request/index.dart';

class CreateTask extends StatefulWidget {
  _CreateTask createState() => new _CreateTask();
}

class _CreateTask extends State {

  String title;

  String target;

  int allDays;

  // 可休假
  int holidayDays;

  // 罚金金额
  double fine;

  // 标签ID
  int tag;

  // 标签文本
  String tagText;

  // 标签颜色
  String tagColor;

  @override
  void initState() {
    super.initState();
  }

  bool checkForm() {
    print('title');
    print(title);
    print('target');
    print(target);
    print('allDays');
    print(allDays);
    print('holidayDays');
    print(holidayDays);
    print('fine');
    print(fine);
    print('tag');
    print(tag);
    if (title != null && target != null && allDays != null && holidayDays != null && fine != null && tag != null) {
      return true;
    }
    return false;
  }

  final _formKey = GlobalKey<FormState>();

  _submit() async {
    print('发送请求了');
    final res = await Request.post('http://127.0.0.1:7001/task/create', {
      'title': title,
      'target': target,
      'allDays': allDays,
      'holidayDays': holidayDays,
      'fine': fine,
      'tag': tag
    });
    print(res);
    if (res != null && res['success'] == true) {
      Navigator.pop(context, 'create');
    }
  }

  _showTags() {
    Navigator.push(context, SlideTopRoute(page: SelectTags(hiddenAll: true))).then((value) {
      print(value);
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
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('创建任务')
        ),
        backgroundColor: Colors.grey[300],
        body: new Container(
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
                                        child: Text(
                                          '目标名称',
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
                                            hintText: '请输入目标名称',
                                            border: InputBorder.none,
                                          ),
                                          // validator: (value) {
                                          //   if (value.isEmpty) {
                                          //     return '请输入目标名称';
                                          //   }
                                          //   return null;
                                          // },
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
                                        child: Text(
                                          '天数',
                                          style: fontStyle,
                                        ),
                                      )
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                                        child: TextFormField(
                                          inputFormatters: [
                                            WhitelistingTextInputFormatter(RegExp("[0-9.]"))
                                          ],
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            hintText: '请输入周期天数',
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
                                        child: Text(
                                          '休假天数',
                                          style: fontStyle,
                                        ),
                                      )
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                                        child: TextFormField(
                                          inputFormatters: [
                                            WhitelistingTextInputFormatter(RegExp("[0-9.]"))
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
                                        child: Text(
                                          '押金',
                                          style: fontStyle,
                                        ),
                                      )
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                                        child: TextFormField(
                                          inputFormatters: [
                                            WhitelistingTextInputFormatter(RegExp("[0-9.]"))
                                          ],
                                          keyboardType: TextInputType.number,
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
                                        child: Text(
                                          '目标',
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
                                            hintText: '目的',
                                            border: InputBorder.none,
                                          ),
                                          // validator: (value) {
                                          //   if (value.isEmpty) {
                                          //     return '请输入目的';
                                          //   }
                                          //   return null;
                                          // },
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
                                height: itemHeight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 100,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                                        child: Text(
                                          '所属分类',
                                          style: fontStyle,
                                        ),
                                      )
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                                        child: TapBox(
                                          onTap: () {
                                            _showTags();
                                          },
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
                                color: Colors.blue[50],
                                child: new Row(
                                  children: <Widget>[
                                    new Icon(
                                      Icons.warning,
                                      color: Colors.blue,
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
                  color: Colors.blue,
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
        )
        
      );
  }
}
