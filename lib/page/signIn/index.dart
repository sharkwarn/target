
/// 这是一个有状态组件，有状态组件必须由两部分构成。StatefulWidget 和 State

import 'package:flutter/material.dart';
import 'package:flutter/Cupertino.dart';
import 'package:flutter/services.dart';
import '../../components/tapBox/index.dart';
import '../../utils/request/index.dart';
import '../../components/countAni/index.dart';
import '../../components/toast/index.dart';
import '../../config.dart';


class SignIn extends StatefulWidget {
  SignIn({
    Key key,
    this.callBack
  }) : super(key: key);

  final Function callBack;

  _SignIn createState() => new _SignIn();
}

class _SignIn extends State<SignIn> {

  String user;

  String msgcode;

  String password;

  Animation<double> animation;
  AnimationController controller;

  bool isForbidden = false;

  bool userError = false;

  String userErrorMsg = '';

  bool msgCodeError = false;

  String msgCodeErrorMsg = '';

  bool passwordError = false;

  String passwordErrorMsg = '';

  @override
  void initState() {
    super.initState();
  }

  sendMsgCode() async {
    if (user == null) {
      setState(() {
        userError = true;
        userErrorMsg = '请输入手机号';
      });
      return;
    } else {
      setState(() {
        userError = false;
        userErrorMsg = '';
      });
    }
    Map res = await Request.post(
      Urls.env + '/login/sendmsg',
      {
        'user': user,
        'type': 'register'
      }
    );
    if (res != null && res['success'] == true) {

    } else if (res != null && res['errmsg'] != null) {
      Toast.toast(
        context,
        msg: res['errmsg'],
        position: ToastPostion.center
      );
    }
    setState(() {
      isForbidden = true;
    });
  }
  
  _submit() async {
    if (user == null) {
      setState(() {
        userError = true;
        userErrorMsg = '请输入手机号 / 邮箱';
      });
    } else {
      setState(() {
        userError = false;
        userErrorMsg = '';
      });
    }

    if (msgcode == null) {
        setState(() {
          msgCodeError = true;
          msgCodeErrorMsg = '请输入验证码';
        });
    } else {
      setState(() {
        msgCodeError = false;
        msgCodeErrorMsg = '';
      });
    }
    
    Map res = await Request.login(
      Urls.env + '/signin',
      {
        'user': user,
        'msgcode': msgcode,
        'password': password
      }
    );
    if (res != null && res['success'] == true) {
      Navigator.pop(context);
    } else if (res != null && res['errmsg'] != null) {
      Toast.toast(
        context,
        msg: res['errmsg'],
        position: ToastPostion.center
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double itemHeight = 50;
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          title: new Text(
            '注册',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20
            ),
          )
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                height: itemHeight,
                decoration: BoxDecoration(
                  border: new Border.all(color: Color(0x2BFAFAFA), width: 1), // 边色与边宽度
                  borderRadius: new BorderRadius.circular((25.0)), // 圆角度
                  color: Color(0X33FFFFFF),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                        child: TextField(
                          style: TextStyle(
                            color: Colors.white
                          ),
                          decoration: const InputDecoration(
                            hintText: '手机号 / 邮箱',
                            hintStyle: TextStyle(
                              color: Color(0X80FFFFFF)
                            ),
                            border: InputBorder.none,
                          ),
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return '请输入目标名称';
                          //   }
                          //   return null;
                          // },
                          onChanged: (val) {
                            user = val;
                          },
                        ),
                      ),
                    )
                  ],
                )
              ),
              Container(
                height: 30,
                padding: EdgeInsets.fromLTRB(13, 4, 13, 0),
                child: Offstage(
                  offstage: !userError,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                      userErrorMsg,
                      style: TextStyle(
                        color: Colors.red
                      ),
                    )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                height: itemHeight,
                decoration: BoxDecoration(
                  border: new Border.all(color: Color(0x2BFAFAFA), width: 1), // 边色与边宽度
                  borderRadius: new BorderRadius.circular((25.0)), // 圆角度
                  color: Color(0X33FFFFFF),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                        child: TextField(
                          style: TextStyle(
                            color: Colors.white
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                          ],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: '验证码',
                            hintStyle: TextStyle(
                              color: Color(0X80FFFFFF)
                            ),
                            border: InputBorder.none,
                          ),
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return '请输入完成天数';
                          //   }
                          //   return null;
                          // },
                          onChanged: (val) {
                            msgcode = val;
                          },
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                        child: TapBox(
                          child: !isForbidden ?  Text(
                            '获取验证码',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ) : Center(
                            child: CountAni(callback: () {
                              setState(() {
                                  isForbidden = false;
                                });
                              },
                            ),
                          ),
                          onTap: () {
                            sendMsgCode();
                          },
                        ),
                      )
                    ),
                  ],
                )
              ),
              Container(
                height: 30,
                padding: EdgeInsets.fromLTRB(13, 4, 13, 0),
                child: Offstage(
                  offstage: !msgCodeError,
                  child: Text(
                    msgCodeErrorMsg,
                    style: TextStyle(
                      color: Colors.red
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                height: itemHeight,
                decoration: BoxDecoration(
                  border: new Border.all(color: Color(0x2BFAFAFA), width: 1), // 边色与边宽度
                  borderRadius: new BorderRadius.circular((25.0)), // 圆角度
                  color: Color(0X33FFFFFF),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                        child: TextField(
                          style: TextStyle(
                            color: Colors.white
                          ),
                          decoration: const InputDecoration(
                            hintText: '密码',
                            hintStyle: TextStyle(
                              color: Color(0X80FFFFFF)
                            ),
                            border: InputBorder.none,
                          ),
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return '请输入目标名称';
                          //   }
                          //   return null;
                          // },
                          onChanged: (val) {
                            password = val;
                          },
                        ),
                      ),
                    )
                  ],
                )
              ),
              Container(
                height: 30,
                padding: EdgeInsets.fromLTRB(13, 4, 13, 0),
                child: Offstage(
                  offstage: !passwordError,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                      passwordErrorMsg,
                      style: TextStyle(
                        color: Colors.red
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  child: Center(
                    child: Text("注册",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  onPressed: (){
                    _submit();
                    // _formKey.currentState.save();
                    // if (checkForm()) {
                    //   // Process data.
                                     
                    // }
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
