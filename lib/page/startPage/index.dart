import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        body: new Center(
          // 如果设置父组件包裹多个多个组件的情况，可以用row,column,
          child: Text('启动页面')
        )
      ),
    );
  }
}