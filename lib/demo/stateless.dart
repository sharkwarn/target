/// @file 这是一个无状态组件

import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        // 如果设置父组件包裹多个多个组件的情况，可以用row,column,
        child: new Row(children: <Widget>[
          // 这个东西的作用只是为了增加间隙
          const SizedBox(width: 30,),
          new Text('文本内容1'),
          const SizedBox(width: 30,),
          new Text('文本内容2'),
          const SizedBox(width: 30,),
          new Text('文本内容3')
        ])
      )
    );
  }
}