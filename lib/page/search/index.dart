/// 这是一个有状态组件，有状态组件必须由两部分构成。StatefulWidget 和 State

import 'package:flutter/material.dart';
import '../../globalData/index.dart';
import '../../components/listTaskItem/index.dart';
import '../../types/index.dart';
import '../../utils/request/index.dart';


class CustomSearchDelegate extends SearchDelegate {

  // 获取数据
Future<List> _fetchData(String str) async {
  final List _lists = await GlobalData.search(str);
  final result = await Request.post('http://127.0.0.1:7001/task/search', {
    'title': str
  });
  print(result);
  if (result != null && result['success'] == true) {
    final lists = result['data'].map<TypesTask>((item) => TypesTask.fromMap(item)).toList();
    return lists;
  } else {
    return [];
  }
}


  // 显示在输入框之后的部件
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      )
    ];
  }

  // 显示在输入框之前的部件，一般显示返回前一个页面箭头按钮
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  // 显示搜索结果
  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: _fetchData(query),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData && snapshot.data.length == 0) {
          return Center(
            child: Text('没有查到数据')
          );
        } else if (snapshot.hasData) {
          final List<Widget> lists = snapshot.data.map<Widget>((TypesTask item) {
            final String title = item.title;
            final int allDays = item.allDays;
            final int holidayDays = item.holidayDays;
            final int dayofftaken = item.dayofftaken;
            final int taskId = item.taskId;
            final Tag tagInfo = item.tagInfo;
            return new ListTaskItem(
                title: title,
                allDays: allDays,
                holidayDays: holidayDays,
                dayofftaken: dayofftaken == null ? 0 : dayofftaken,
                tagInfo: tagInfo,
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/detail', arguments: taskId)
                      .then((value) => {
                          });
                });
          }).toList();
          return ListView(
            children: lists,
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  // 显示搜索建议
  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: <Widget>[
        
      ],
    );
  }
}
