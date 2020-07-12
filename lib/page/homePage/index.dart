import 'package:flutter/material.dart';
import 'package:flutter/Cupertino.dart';
import '../../components/listTaskItem/index.dart';
import '../../mock/index.dart';
import '../../globalData/index.dart';
import '../../types/index.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;

  List<TypesTask> _tasks = [];

  @override
  initState() {
    super.initState();
    _getList();
  }
  
  _getList() async {
    final _lists = await GlobalData.getList();
    final lists = _lists.map((item)=>TypesTask.fromMap(item)).toList();
    setState(() {
      _tasks = lists;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> lists = _tasks.map((item) {
      final String title = item.title;
      final int allDays = item.allDays;
      final int holidayDays = item.holidayDays;
      final int dayofftaken = item.dayofftaken;
      final int id = item.id;
      return new ListTaskItem(
        title: title,
        allDays: allDays,
        holidayDays: holidayDays,
        dayofftaken: dayofftaken == null ? 0 : dayofftaken,
        onTap: () {
          Navigator.of(context).pushNamed('/detail', arguments: id);
        }
      );
    }).toList();
    return new Scaffold(
      appBar: new AppBar(
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Text('首页'),
            new Row(
              children: <Widget>[
                new IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/search');
                  },
                ),
                new Text('|'),
                new IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/create').then((value) => {
                      if (value == 'create') {
                        _getList()
                      }
                    });
                  },
                )
              ],
            )
          ],
        )
      ),
      body: new Column(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new CupertinoButton(
                child: new Text('排序'),
                onPressed: () {
                },
              ),
              new CupertinoButton(
                child: new Text('筛选'),
                onPressed: () {
                },
              )
            ]
          ),
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
      )
    );
  }
}