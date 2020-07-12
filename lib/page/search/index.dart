/// 这是一个有状态组件，有状态组件必须由两部分构成。StatefulWidget 和 State

import 'package:flutter/material.dart';



class SearchTask extends StatefulWidget {
  _SearchTask createState() => new _SearchTask();
}

class _SearchTask extends State {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new TextField(
            obscureText: false
          )
        ),
        body: new Center(
          // 如果设置父组件包裹多个多个组件的情况，可以用row,column,
          child: new Text('搜索页面')
        )
      );
  }
}
