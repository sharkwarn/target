import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import './page/homePage/index.dart';
import './page/createTask/index.dart';
import './page/search/index.dart';
import './page/taskDetail/index.dart';
import './page/checkTask/index.dart';
import './globalData/index.dart';
void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      home: new HomePage(),
      routes: <String, WidgetBuilder> {
        '/create': (BuildContext context) => new CreateTask(),
        '/search': (BuildContext context) => new SearchTask(),
        '/detail': (BuildContext context) => new TaskDetail(),
        '/checktask': (BuildContext context) => new CheckTask(),
      },
    );
  }
}