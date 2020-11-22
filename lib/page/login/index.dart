
/// 这是一个有状态组件，有状态组件必须由两部分构成。StatefulWidget 和 State

import 'package:flutter/material.dart';
import 'package:flutter/Cupertino.dart';
import 'package:flutter/services.dart';
import '../../components/tapBox/index.dart';
import '../../utils/request/index.dart';
import '../../components/countAni/index.dart';
import '../../components/toast/index.dart';
import '../../ani/wave/index.dart';
import '../../config.dart';


class Login extends StatefulWidget {
  Login({
    Key key,
    this.callBack
  }) : super(key: key);

  final Function callBack;

  _Login createState() => new _Login();
}

class _Login extends State<Login> {

  String user;

  String msgcode;

  String password;

  String type = 'password';

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
        'user': user
      }
    );
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
      return;
    } else {
      setState(() {
        userError = false;
        userErrorMsg = '';
      });
    }

    if (type != 'password' && msgcode == null) {
      setState(() {
        msgCodeError = true;
        msgCodeErrorMsg = '请输入验证码';
      });
      return;
    } else {
      setState(() {
        msgCodeError = false;
        msgCodeErrorMsg = '';
      });
    }

    if (type == 'password' && password == null) {
      setState(() {
        passwordError = true;
        passwordErrorMsg = '请输入密码';
      });
      return;
    } else {
      setState(() {
        passwordError = false;
        passwordErrorMsg = '';
      });
    }
    
    Map<String, dynamic> obj = {
      'user': user,
    };
    if (type == 'password') {
      obj['password'] = password;
    } else {
      obj['msgcode'] = msgcode;
    }
    print('发起请求');
    Map res = await Request.login(
      Urls.env + '/login',
      obj
    );
    if (res != null && res['success'] == true) {
      widget.callBack();
      return;
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
    final TextStyle fontStyle = TextStyle(
      fontSize: 16,
      color: Color(0X80FFFFFF)
    );
    return new Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              AniWave(),
              Container(
                margin: EdgeInsets.fromLTRB(0, 200, 0, 0),
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
              Offstage(
                offstage: type == 'password',
                child: Container(
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
              ),
              Offstage(
                offstage: type == 'password',
                child: Container(
                  height: 20,
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
              ),
              Offstage(
                offstage: type != 'password',
                child: Container(
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
                            ],
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: '密码',
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
                              password = val;
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ),
              ),
              Offstage(
                offstage: type != 'password',
                child: Container(
                  height: 20,
                  child: Offstage(
                    offstage: !passwordError,
                    child: Text(
                      passwordErrorMsg,
                      style: TextStyle(
                        color: Colors.red
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(13, 0, 13, 0),
                margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TapBox(
                      onTap: () {
                        setState(() {
                          type = type == 'password' ? 'msgcode' : 'password';
                        });
                      },
                      child: Text(
                        type == 'password' ? '验证码登录' : '密码登录',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        )
                      ),
                    ),
                    TapBox(
                      onTap: () {
                        Navigator.of(context).pushNamed('/signIn');
                      },
                      child: Text(
                        '注册',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        )
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 50,
                child: new CupertinoButton(
                  minSize: double.infinity,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  child: Center(
                    child: Text("登录",
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
              ),
            ]
          ),
        )
        
      );
  }
}
