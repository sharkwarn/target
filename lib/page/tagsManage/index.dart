/// 这是一个有状态组件，有状态组件必须由两部分构成。StatefulWidget 和 State

import 'package:flutter/material.dart';
import 'package:flutter/Cupertino.dart';
import '../../types/index.dart';
import '../../utils/colorsUtil.dart';
import '../../components/pageAnimation/index.dart';
import './createTag/index.dart';
import '../../utils/request/index.dart';
import '../../config.dart';
import '../../components/tapBox/index.dart';



class TagsManage extends StatefulWidget {
  _TagsManage createState() => new _TagsManage();
}

class _TagsManage extends State {

  String name = '';

  String color = '';

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

  _createTag() async {
    Navigator.push(context, SlideTopRoute(page: CreateTags())).then((value) => {
      if (value == 'create') {
        _getList()
      }
    });
  }

  _editeTag(Tag tag) async {
    Navigator.push(context, SlideTopRoute(
      page: CreateTags(
        tagId: tag.tagId,
        name: tag.name,
        color: tag.color
      )
    )).then((value) => {
      if (value == 'create') {
        _getList()
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> lists = tags.map<Widget>((item) {
      final String name = item.name;
      final String color = item.color;
      return Container(
        width: MediaQuery.of(context).size.width * 0.50,
        height: 64,
        padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: TapBox(
          onTap: () => {
            _editeTag(item)
          },
          child: Container(
            decoration: new BoxDecoration(
              //背景
              color: ColorsUtil.hexStringColor(color),
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
                  name,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  )
                )
              ],
            ),
          ),
        )
      );
    }).toList();
    return new Scaffold(
        appBar: new AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(''),
              Text('标签管理'),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  _createTag();
                },
              )
            ],
          )
        ),
        body: ListView(children: <Widget>[
          Wrap(
            children: lists,
          )
        ],)
      );
  }
}
