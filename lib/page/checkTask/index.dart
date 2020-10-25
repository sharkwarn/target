
/// 这是一个有状态组件，有状态组件必须由两部分构成。StatefulWidget 和 State

import 'package:flutter/material.dart';
import 'package:flutter/Cupertino.dart';
import 'package:flutter/services.dart';
import '../../utils/request/index.dart';
import '../../components/toast/index.dart';
import '../../config.dart';



class CheckTask extends StatefulWidget {

  _CheckTask createState() => new _CheckTask();
}

class _CheckTask extends State<CheckTask> {
  String _selection = 'sign';
  String remark= '';
  String type = 'sign';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Map arguments = ModalRoute.of(context).settings.arguments;
      setState(() {
        if (arguments != null && arguments['type'] != null) {
          type = arguments['type'];
          _selection = arguments['type'];
        }
      });
    });
  }

  _submit () async {
    final Map<String, dynamic> arg = ModalRoute.of(context).settings.arguments;
    final params = {
      'taskId': arg['taskId'],
      'type': _selection,
      'remark': remark
    };
    final result = await Request.post(Urls.env + '/log/create', params);
    if (result != null && result['success'] == true) {
       Navigator.pop(context, true);
    } else if (result != null && result['errmsg'] != null) {
      Toast.toast(
        context,
        msg: result['errmsg'],
        position: ToastPostion.center
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String typeText;
    switch (_selection) {
      case 'sign':
        typeText = '签到';
        break;
      case 'holiday':
        typeText = '休假';
        break;
      case 'fail':
        typeText = '判定失败';
        break;
      default:
        typeText = '签到';
        break;
    }
    return new Scaffold(
        appBar: new AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PopupMenuButton(
                onSelected: (result) { setState(() { _selection = result; }); },
                itemBuilder: (BuildContext context) {
                  if (type == 'fail') {
                    return <PopupMenuEntry>[
                      const PopupMenuItem(
                        value: 'fail',
                        child: Text('判定失败'),
                      ),
                    ];
                  } else {
                    return <PopupMenuEntry>[
                      const PopupMenuItem(
                        value: 'sign',
                        child: Text('签到'),
                      ),
                      const PopupMenuItem(
                        value: 'holiday',
                        child: Text('休假'),
                      ),
                    ];
                  }
                },
                child: Row(children: <Widget>[
                  Text(typeText),
                  Icon(Icons.arrow_drop_down)
                ],),
              )
            ],
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
                                    hintText: '请输入内容',
                                    border: InputBorder.none,
                                  ),
                                  validator: (value) {
                                    return null;
                                  },
                                  onSaved: (val) {
                                    remark = val;
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
