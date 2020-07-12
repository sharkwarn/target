
/// 这是一个有状态组件，有状态组件必须由两部分构成。StatefulWidget 和 State

import 'package:flutter/material.dart';
import 'package:flutter/Cupertino.dart';
import 'package:flutter/services.dart';


class CheckTask extends StatefulWidget {
  _CheckTask createState() => new _CheckTask();
}

class _CheckTask extends State {
  int count = 0;
  bool needPay = false;
  String _selection = 'check';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: PopupMenuButton(
            onSelected: (result) { setState(() { _selection = result; }); },
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              const PopupMenuItem(
                value: 'check',
                child: Text('签到'),
              ),
              const PopupMenuItem(
                value: 'holiday',
                child: Text('休假'),
              ),
            ],
            child: Row(children: <Widget>[
              Text(_selection == 'check' ? '签到' : '休假'),
              Icon(Icons.arrow_drop_down)
            ],),
          ),
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
                        color: Colors.white,
                        child: new Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                                child: TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 10,
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
