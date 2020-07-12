import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';
import '../types/index.dart';


class _GlobalData {

  SharedPreferences prefs;

  _GlobalData() {
    _init();
  }

  _init() async {
    if (prefs != null) {
      return prefs;
    }
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  Future<List> getList() async {
    final SharedPreferences db = await _init();
    final String listStr = db.getString('tasks');
    if (listStr == null) {
      return [];
    } else {
      final a = convert.jsonDecode(listStr);
      return a;
    }
  }

  add(
      title,
      target,
      allDays,
      holidayDays,
      dayofftaken,
      isfine,
      fine
    ) async {
    final tasklist = await getList();
    final obj =  {
      'id': tasklist.length > 1 ? tasklist[tasklist.length - 1]['id'] + 1 : 0,
      'title': title,
      'target': target,
      'dateCreated': '2018-12-21',
      'allDays': allDays,
      'holidayDays': holidayDays,
      'dayofftaken': dayofftaken,
      'isfine': isfine,
      'fine': fine,
      'supervisor': null,
      'checklogs': [],
      'status': '2'
    };
    tasklist.add(obj);
    final res = await save(tasklist);
    return res;
  }


  getDetail(id) async {
    final list = await getList();
    var res = list.firstWhere((item)=> item.id == id);
    print(res);
    return res;
  }

  save(params) async {
    final SharedPreferences db = await _init();
    bool res = await db.setString('tasks', convert.jsonEncode(params));
    if (res) {
      print('保存成功');
    } else {
      print('保存失败');
    }
    return res;
  }

}

final GlobalData = _GlobalData();