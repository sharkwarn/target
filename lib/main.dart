import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import './page/homePage/index.dart';
import './page/createTask/index.dart';
import './page/taskDetail/index.dart';
import './page/checkTask/index.dart';
import './page/tagsManage/index.dart';
import './page/login/index.dart';
import './page/startPage/index.dart';

import './utils/request/index.dart';
void main() {
  runApp(new App());
}

class App extends StatefulWidget {
  _App createState() => _App();
}

class _App extends State<App> {

  bool startPage = true;

  bool noLogin = false;

  @override
  void initState() {
    super.initState();
    _init();
  }


  _init() async {
    // 开机先进行启动页面，实例基础控件，此过程进行登录验证
    bool res =  await Request.init();
    print('验证结果');
    print(res);
    if (res) {
      setState(() {
        startPage = false;
        noLogin = false;
      });
    } else {
        startPage = false;
        noLogin = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (startPage) {
      return StartPage();
    }

    if (noLogin) {
      return Login();
    }
    return new MaterialApp(
      title: 'Flutter Demo',
      home: new HomePage(),
      routes: <String, WidgetBuilder> {
        '/login': (BuildContext context) => new Login(),
        '/create': (BuildContext context) => new CreateTask(),
        '/detail': (BuildContext context) => new TaskDetail(),
        '/checktask': (BuildContext context) => new CheckTask(),
        '/tagsManage': (BuildContext context) => new TagsManage(),
      },
    );
  }
}