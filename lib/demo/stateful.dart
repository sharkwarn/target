/// 这是一个有状态组件，有状态组件必须由两部分构成。StatefulWidget 和 State

import 'package:flutter/material.dart';



class CusCount extends StatefulWidget {
  CountNum createState() => new CountNum();
}

class CountNum extends State {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('有状态组件')
        ),
        body: new Center(
          // 如果设置父组件包裹多个多个组件的情况，可以用row,column,
          child: new Row(children: <Widget>
            [
              RaisedButton(
                onPressed: () {
                  setState(() {
                    --this.count;
                  });
                },
                child: new Text('-'),
              ),
              new Text(count.toString()),
              RaisedButton(
                child: new Text('+'),
                onPressed: () {
                  setState(() {
                    ++this.count;
                  });
                },
              )
            ],
          )
        )
      );
  }
}
