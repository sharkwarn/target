import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import './route.dart';

import './page/homePage/index.dart';
import './page/createTask/index.dart';
import './page/taskDetail/index.dart';
import './page/checkTask/index.dart';
import './page/tagsManage/index.dart';
import './page/history/index.dart';
import './page/login/index.dart';
import './page/startPage/index.dart';
import './page/rewardList/index.dart';
import './page/signIn/index.dart';
import './page/redictLogin/index.dart';
import './page/timeLine/index.dart';

import './modal/count.dart';
import './modal/login.dart';

import './utils/request/index.dart';
void main() async {

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterModel()),
        ChangeNotifierProvider(create: (_) => LoginModal()),
      ],
      child: App(),
    )
  );

  // runApp(Provider<int>.value(
  //     value: textSize,
  //     child: ChangeNotifierProvider.value(
  //       value: counter,
  //       child: App(),
  //     ),
  //   ),
  // );
}

class App extends StatefulWidget {
  _App createState() => _App();
}

class _App extends State<App> {

  bool startPage = true;

  @override
  void initState() {
    super.initState();
    _init();
  }


  _init() async {
    // 开机先进行启动页面，实例基础控件，此过程进行登录验证
    bool res =  await Request.init();
    new Future.delayed(Duration(seconds: 1),(){
      if (res) {
        Provider.of<LoginModal>(context, listen: false).changeStatus(true);
        setState(() {
          startPage = false;
        });
      } else {
          setState(() {
            startPage = false;
          });
      }
	  });
    
  }

  @override
  Widget build(BuildContext context) {
    final _login = Provider.of<LoginModal>(context);
    if (startPage) {
      return StartPage();
    }

    if (!_login.value) {
      return MaterialApp(
        title: ' ',
        theme: ThemeData(
          primaryColor: Theme.of(context).primaryColor,
        ),
        home: Login(
          callBack: () {
            setState(() {
              startPage = false;
              _login.changeStatus(true);
            });
          }
        ),
        routes: <String, WidgetBuilder> {
          '/signIn': (BuildContext context) => new SignIn()
        },
      );
    }
    return new MaterialApp(
      title: ' ',
      home: new HomePage(),
      theme: ThemeData(
        brightness: Brightness.light,
        cupertinoOverrideTheme: CupertinoThemeData(
            brightness: Brightness.light
        ),
      ),
      navigatorKey: GloabalRouter.navigatorKey,
      routes: <String, WidgetBuilder> {
        '/redictLogin': (BuildContext context) => new RedictLogin(),
        '/create': (BuildContext context) => new CreateTask(),
        '/detail': (BuildContext context) => new TaskDetail(),
        '/checktask': (BuildContext context) => new CheckTask(),
        '/tagsManage': (BuildContext context) => new TagsManage(),
        '/history': (BuildContext context) => new History(),
        '/rewardList': (BuildContext context) => new RewardList(),
        '/timeline': (BuildContext context) => new TimeLine()
      },
    );
  }
}