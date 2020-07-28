import 'package:flutter/material.dart';
import 'package:flutter/Cupertino.dart';
import 'package:flutter_app2/components/tapBox/index.dart';
import '../../components/listTaskItem/index.dart';
import '../../globalData/index.dart';
import '../search/index.dart';
import '../../types/index.dart';
import '../tagsManage/index.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TypesTask> _tasks = [];

  @override
  initState() {
    super.initState();
    _getList();
  }

  _getList() async {
    final _lists = await GlobalData.getList();
    print(_lists);
    final lists = _lists.map((item) => TypesTask.fromMap(item)).toList();
    setState(() {
      _tasks = lists;
    });
  }

  _showTags() {
    Navigator.push(
        context, CupertinoPageRoute(builder: (context) => TagsManage()));
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> lists = _tasks.map((item) {
      final String title = item.title;
      final int allDays = item.allDays;
      final int holidayDays = item.holidayDays;
      final int dayofftaken = item.dayofftaken;
      final int id = item.id;
      final Tag tagInfo = item.tagInfo;
      return new ListTaskItem(
          title: title,
          allDays: allDays,
          holidayDays: holidayDays,
          dayofftaken: dayofftaken == null ? 0 : dayofftaken,
          tagInfo: tagInfo,
          onTap: () {
            print(id);
            Navigator.of(context)
                .pushNamed('/detail', arguments: id)
                .then((value) => {
                      if (value) {_getList()}
                    });
          });
    }).toList();
    return new Scaffold(
        appBar: new AppBar(
            title: new Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new Row(
              children: <Widget>[
                new IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                        context: context, delegate: CustomSearchDelegate());
                  },
                ),
                new Text('|'),
                new IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/create').then((value) => {
                          if (value == 'create') {_getList()}
                        });
                  },
                )
              ],
            )
          ],
        )),
        body: new Column(
          children: <Widget>[
            Stack(
              children: <Widget>[Text('aaaa')],
            ),
            new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new CupertinoButton(
                    child: new Text('排序'),
                    onPressed: () {},
                  ),
                  new CupertinoButton(
                    child: new Text('筛选'),
                    onPressed: () {
                      _showTags();
                    },
                  )
                ]),
            new Expanded(
              flex: 1,
              child: new Container(
                child: new ListView(
                  padding: const EdgeInsets.all(8),
                  children: lists,
                ),
              ),
            )
          ],
        ),
        drawer: Drawer(
            child: Container(
          padding: EdgeInsets.fromLTRB(0, 40, 0, 40),
          child: ListView(
            children: <Widget>[
              Container(
                child: Card(
                  child: Row(
                    children: <Widget>[
                      TapBox(
                        onTap: () {
                          Navigator.of(context).pushNamed('/tagsManage');
                          // .then((value) => {
                          //   if (value == 'create') {
                          //     _getList()
                          //   }
                          // });
                        },
                        child: Row(
                          children: <Widget>[Icon(Icons.menu), Text('标签管理')],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                child: Card(
                  child: Row(
                    children: <Widget>[
                      TapBox(
                        onTap: () async {
                          bool res = await GlobalData.clear();
                          if (res) {
                            _getList();
                          }
                        },
                        child: Row(
                          children: <Widget>[Icon(Icons.refresh), Text('清除打卡')],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )));
  }
}
