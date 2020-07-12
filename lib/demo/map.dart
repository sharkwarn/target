import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'My app', // used by the OS task switcher
      home: new Scaffold(
        body: new Center(
          // 如果设置父组件包裹多个多个组件的情况，可以用row,column,
          child: new MyContainer()
        )
      ),
    );
  }
}

class MyContainer extends StatefulWidget {
  CountNum createState() => new CountNum();
}

class CountNum extends State {
  int count = 5;
  @override
  Widget build(BuildContext context) {
    List<Widget> texts = [];
    for(var i = 0; i < this.count; i++) {
      texts.add(new Text('text:' + i.toString()));
    }
    texts.add(CupertinoButton(
      onPressed: () {
        print('点击了');
        setState(() {
          this.count++;
        });
      },
      child: new Text('添加')
    ));
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: texts,
    );
  }
}
