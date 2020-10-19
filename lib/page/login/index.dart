
/// 这是一个有状态组件，有状态组件必须由两部分构成。StatefulWidget 和 State

import 'package:flutter/material.dart';
import 'package:flutter/Cupertino.dart';
import 'package:flutter/services.dart';
import '../../components/tapBox/index.dart';
import '../../utils/request/index.dart';
import '../../components/countAni/index.dart';
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

  String phone;

  String msgcode;

  Animation<double> animation;
  AnimationController controller;

  bool isForbidden = false;

  bool phoneError = false;
  String phoneErrorMsg = '';

  bool msgCodeError = false;
  String msgCodeErrorMsg = '';

  @override
  void initState() {
    super.initState();
  }

  sendMsgCode() async {
    if (phone == null) {
      setState(() {
        phoneError = true;
        phoneErrorMsg = '请输入手机号';
      });
      return;
    } else {
      setState(() {
        phoneError = false;
        phoneErrorMsg = '';
      });
    }
    Map res = await Request.post(
      Urls.env + '/login/sendmsg',
      {
        'phone': phone
      }
    );
    setState(() {
      isForbidden = true;
    });
  }
  
  _submit() async {
    if (phone == null) {
      setState(() {
        phoneError = true;
        phoneErrorMsg = '请输入手机号';
      });
    } else {
      setState(() {
        phoneError = false;
        phoneErrorMsg = '';
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
      Urls.env + '/login',
      {
        'phone': phone,
        'msgcode': msgcode
      }
    );
    if (res != null && res['success'] == true) {
      widget.callBack();
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    double itemHeight = 50;
    final TextStyle fontStyle = TextStyle(
      fontSize: 16,
      color: Colors.black
    );
    return new Scaffold(
        backgroundColor: Colors.green[300],
        body: Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                        child: TextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                          ],
                          decoration: const InputDecoration(
                            hintText: '请输入手机号',
                            border: InputBorder.none,
                          ),
                          // validator: (value) {
                          //   if (value.isEmpty) {
                          //     return '请输入目标名称';
                          //   }
                          //   return null;
                          // },
                          onChanged: (val) {
                            phone = val;
                          },
                        ),
                      ),
                    )
                  ],
                )
              ),
              Container(
                height: itemHeight,
                child: Offstage(
                  offstage: !phoneError,
                  child: Text(
                    phoneErrorMsg,
                    style: TextStyle(
                      color: Colors.red
                    ),
                  ),
                ),
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
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                        child: TextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9]"))
                          ],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: '请输入验证码',
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
                            style: fontStyle,
                          ) : CountAni(callback: () {
                            setState(() {
                              isForbidden = false;
                            });
                          },),
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
                height: itemHeight,
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
                height: 50,
                child: new CupertinoButton(
                  minSize: double.infinity,
                  child: Text("登录",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.blue,
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
