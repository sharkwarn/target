
/// 这是一个有状态组件，有状态组件必须由两部分构成。StatefulWidget 和 State

import 'package:flutter/material.dart';
import 'package:flutter/Cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picker/flutter_picker.dart';
import '../../components/tapBox/index.dart';

import '../../globalData/index.dart';

import '../../types/index.dart';


class CreateTask extends StatefulWidget {
  _CreateTask createState() => new _CreateTask();
}

class _CreateTask extends State {

  String title;

  String target;

  int allDays;

  // 可休假
  int holidayDays;

  // 已经休假
  int dayofftaken;

  // 罚金模式
  bool isfine = true;

  // 罚金金额
  double fine;

  // 标签ID
  int tag;

  // 标签文本
  String tagText;

  List tags = [];

  @override
  void initState() {
    super.initState();
    _getList();
  }

  _getList() async {
    print('重新加载数据');
    final _lists = await GlobalData.getTagsList();
    print(_lists);
    final lists = _lists.map((item)=>Tag.fromMap(item)).toList();
    setState(() {
      tags = lists;
    });
  }


  final _formKey = GlobalKey<FormState>();

  _submit() async {
    final res = await GlobalData.add(
      title,
      target,
      allDays,
      holidayDays,
      dayofftaken,
      isfine,
      fine,
      tag
    );
    print('结果');
    if (res) {
      Navigator.pop(context, 'create');
    }
  }

  showPickerNumber(BuildContext context) {
    Picker(
        adapter: PickerDataAdapter(
          pickerdata: tags.map((item) {
            return item.name;
          }).toList(),
        ),
        changeToFirst: false,
        textAlign: TextAlign.left,
        textStyle: const TextStyle(color: Colors.blue),
        selectedTextStyle: TextStyle(color: Colors.red),
        columnPadding: const EdgeInsets.all(8.0),
        cancelText: '取消',
        confirmText: '确定',
        onConfirm: (Picker picker, List value) {
          int index = value[0];
          final Tag item = tags[index];
          print(item.id);
          setState(() {
            tag = item.id;
            print(tag);
            tagText = item.name;
          });
        }
    ).showModal(context);
  }

  @override
  Widget build(BuildContext context) {
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
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                  child: new Text(
                                  '任务一旦开始后不可以结束，其他一堆乱七八糟的，我爱我老婆，我做饭很难吃，超级难受。',
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
                      new Container(
                        color: Colors.white,
                        child: new Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: '目标名称',
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return '请输入目标名称';
                                    }
                                    return null;
                                  },
                                  onSaved: (val) {
                                    title = val;
                                  },
                                )
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                                child: TextFormField(
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter(RegExp("[0-9.]"))
                                  ],
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    hintText: '目标完成天数',
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return '请输入完成天数';
                                    }
                                    return null;
                                  },
                                  onSaved: (val) {
                                    allDays = int.parse(val);
                                  },
                                )
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                                child: TextFormField(
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter(RegExp("[0-9.]"))
                                  ],
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    hintText: '希望休假天数',
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return '请输入休假天数';
                                    }
                                    return null;
                                  },
                                  onSaved: (val) {
                                    holidayDays = int.parse(val);
                                  },
                                )
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                                child: TapBox(
                                  onTap: () {
                                    showPickerNumber(context);
                                  },
                                  child: Text(tagText != null ? tagText :'选择标签')
                                )
                              ),
                              MergeSemantics(
                                child: ListTile(
                                  title: Text('押金模式'),
                                  trailing: CupertinoSwitch(
                                    value: isfine,
                                    onChanged: (bool value) { setState(() { isfine = value; }); },
                                  ),
                                  onTap: () { setState(() { isfine = !isfine; }); },
                                ),
                              ),
                              Offstage(
                                offstage: !isfine,
                                child: new Padding(
                                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                                  child: TextFormField(
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter(RegExp("[0-9.]"))
                                    ],
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: '金额',
                                      border: InputBorder.none,
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return '请输入金额';
                                      }
                                      return null;
                                    },
                                    onSaved: (val) {
                                      fine = double.parse(val);
                                    },
                                  )
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: '目的',
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return '请输入目的';
                                    }
                                    return null;
                                  },
                                  onSaved: (val) {
                                    target = val;
                                  },
                                )
                              ),
                            ],
                          ),
                        ),
                      )
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
                    if (_formKey.currentState.validate()) {
                      // Process data.
                      _formKey.currentState.save();
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
