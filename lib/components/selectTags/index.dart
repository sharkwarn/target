import 'package:flutter/material.dart';

import '../../utils/colorsUtil.dart';
import '../../types/index.dart';
import '../../utils/request/index.dart';
import '../tapBox/index.dart';
import '../../config.dart';


class SelectTags extends StatefulWidget {
  SelectTags({
    Key key,
    this.hiddenAll
  }): super(key: key);

  final bool hiddenAll;

  @override
  _SelectTags createState() => _SelectTags();

}

class _SelectTags extends State<SelectTags> {

  List selects = [];

  List<Tag> tags = [];

  @override
  initState() {
    super.initState();
    _getList();
  }
  
  _getList() async {    
    final result = await Request.post(Urls.env + '/tag/getList', {});
    if (result != null && result['success'] == true) {
      final _lists = result['data'];
      final lists = _lists.map<Tag>((item)=>Tag.fromMap(item)).toList();
      setState(() {        
        tags = lists;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> colors = tags.map<Widget>((item) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.50,
        height: 64,
        padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: TapBox(
          onTap: () {
            Navigator.pop(context, item);
          },
          child: Container(
            decoration: new BoxDecoration(
              //背景
              color: ColorsUtil.hexStringColor(item.color),
              //设置四周圆角 角度
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              //设置四周边框
              // border: new Border.all(width: 1, color: Colors.red),
            ),
            height: 88,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  item.name,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  )
                )
              ],
            ),
          )
        )
      );
    }).toList();
    if (widget.hiddenAll != true) {
        colors.insert(0, Container(
          width: MediaQuery.of(context).size.width * 0.50,
          height: 64,
          padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
          child: TapBox(
            onTap: () {
              Navigator.pop(context, '全部');
            },
            child: Container(
              decoration: new BoxDecoration(
                //背景
                color: Colors.white,
                //设置四周圆角 角度
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                //设置四周边框
                border: new Border.all(width: 1, color: Colors.blue),
              ),
              height: 88,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '全部',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.blue,
                    )
                  )
                ],
              ),
            )
          )
        )
      );
    }

    return new Scaffold(
        appBar: new AppBar(
          title: Text('选择标签')
        ),
        body:ListView(
          children: <Widget>[
            Wrap(
              children: colors,
            )
          ],
        )
      );
  }

}