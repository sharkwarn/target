import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';
import '../types/index.dart';
import '../utils/date.dart';


class GlobalData {

  static SharedPreferences prefs;

  GlobalData() {
    _init();
  }

  static _init() async {
    if (prefs != null) {
      return prefs;
    }
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  /*
   * 对日期进行检查，未打卡的判定为失败，或者补为假期。
   */
  static decorateList() async {
    final list = await getList();

  }

  // 检查打开时间，判断是否缺勤，如果缺勤补全休假
  static checkTaskLog(Map detail) {
    try {
      if (detail['checklogs'].length == detail['allDays']) {
        print('已成功');
        return;
      }
      DateTime lastUpdate = detail['checklogs'].length > 0
      ? DateTime.parse(detail['checklogs'][0]['checkTime'])
      : DateTime.parse(detail['dateCreated']).add(Duration(days: -1));
      final DateTime nowTime = DateTime.now();
      int x = nowTime.difference(lastUpdate).inDays;
      int holidayDays = detail['holidayDays'];
      int allDays = detail['allDays'];
      while (x > 1) {
        if (holidayDays == 0) {
            print('没有休假，任务失败');
            break;
        }
        lastUpdate.add(Duration(days: 1));
        detail['checklogs'].insert(0, {
            'checkTime': lastUpdate.toString(),
            'remark': '未打卡自动休假',
            'isVacation': true
        });
        x--;
        holidayDays--;
        if (detail['checklogs'].length == allDays) {
            print('任务完成');
            break;
        }
      }
    } catch(err) {
      print(err);
    }
    
  }

  static Future<List> getList() async {
    final SharedPreferences db = await _init();
    final String listStr = db.getString('tasks');
    if (listStr == null) {
      return [];
    } else {
      final a = convert.jsonDecode(listStr);
      final tags = await getTagsList();
      final Map<int, dynamic> obj = {};
      tags.forEach((item) {
        if (item != null) {
          obj[item['id']] = item;
        }
      });
      return a.map((item) {
        checkTaskLog(item);
        if (item['tag'] != null) {
          item['tagInfo'] = obj[item['tag']];
        }
        return item;
      }).toList();
    }
  }

  static Future<List> getTagsList() async {
    final SharedPreferences db = await _init();
    final String listStr = db.getString('tags');
    if (listStr == null) {
      return [];
    } else {
      final a = convert.jsonDecode(listStr);
      return a;
    }
  }

  static add(
      title,
      target,
      allDays,
      holidayDays,
      dayofftaken,
      isfine,
      fine,
      tag
    ) async {
    final tasklist = await getList();
    final obj =  {
      'id': tasklist.length >= 1 ? tasklist[tasklist.length - 1]['id'] + 1 : 0,
      'title': title,
      'target': target,
      'tag': tag,
      'dateCreated': new DateTime.now().toString(),
      'allDays': allDays,
      'holidayDays': holidayDays,
      'dayofftaken': dayofftaken,
      'isfine': isfine,
      'fine': fine,
      'supervisor': null,
      'checklogs': [],
      'lastUpdate': null,
      'status': '2'
    };
    tasklist.insert(0, obj);
    final res = await save(tasklist);
    return res;
  }


  static addTag(
      name,
      color
    ) async {
    final tagsList = await getTagsList();
    final obj =  {
      'id': tagsList.length >= 1 ? tagsList[tagsList.length - 1]['id'] + 1 : 0,
      'name': name,
      'color': color
    };
    tagsList.insert(0, obj);
    final res = await saveTags(tagsList);
    return res;
  }
  
  // 打卡记录
  static addChecklog(int id, log) async {
    final list = await getList();
    int index = list.indexWhere((item)=> item['id'] == id);
    if (list[index] == null) {
      return false;
    }
    final Map<String, dynamic> detail = list[index];
    final List checklogs = detail['checklogs'];
    checklogs.insert(0, {
      'checkTime':  DateTime.now().toString(),
      'remark': log['remark'],
      'isVacation': log['isVacation'],
      'imgs': []
    });
    bool res = await save(list);
    return res;
  }

  static update(int id, Map<String, dynamic> params) async {
    final list = await getList();
    int index = list.indexWhere((item)=> item['id'] == id);
    // List newList = list.expand((element) {
    //   if (element.id == id) {

    //   }
    // });
    if (list[index] == null) {
      return false;
    }
    params.forEach((key, value) {
      if (list[index].containsKey(key)) {
        list[index][key] = value;
      }
    });
    bool res = await save(list);
    return res;
  }

  static getDetail(id) async {
    final list = await getList();
    var res = list.firstWhere((item)=> item['id'] == id);
    return res;
  }

  static save(params) async {
    print(params);
    final SharedPreferences db = await _init();
    bool res = await db.setString('tasks', convert.jsonEncode(params));
    if (res) {
      print('保存成功');
    } else {
      print('保存失败');
    }
    return res;
  }

  static saveTags(params) async {
    final SharedPreferences db = await _init();
    bool res = await db.setString('tags', convert.jsonEncode(params));
    if (res) {
      print('保存成功');
    } else {
      print('保存失败');
    }
    return res;
  }

  static clear() async {
    bool res = await save([]);
    return res;
  }

  static clearTags() async {
    bool res = await saveTags([]);
    return res;
  }

  static search(String query) async {
    final List list = await getList();
    final List result = list.where((item) {
      String title = item['title'];
      if (title.indexOf(query) > -1) {
        return true;
      } else {
        return false;
      }
    }).toList();
    return result;
  }
}
