class TypesTask {

  // taskId
  int taskId;

  // 任务目标
  String title;

  // 目的
  String target;

  // 创建日期
  String dateCreated;

  // 分类
  int tag;

  //总日期
  int allDays;

  // 可休假
  int holidayDays;

  // 已经休假
  int dayofftaken;

  // 罚金模式
  bool isfine;

  // 罚金金额
  double fine;

  // 监督者
  TypesSupervisor supervisor;

  // 打卡日志
  List<TypesLog> logs;

  // 状态
  String status;

  // 最后一次更新时间
  String lastUpdate;

  // 今日的打卡状态
  String currentStatus;

  // 当前第几天
  int currentDay;

  // 已经过去几天
  int completedDay;

  // 已经签到多少天
  int haveSignDays;

  // 之前完成多少天
  int preAllDays;
  

  // 惩罚
  String punishment;
  // 奖励
  String reward;

  // 计数开关
  int counter;
  // 计数次数
  int count;
  // 计数时间
  String countTime;

  Tag tagInfo;

  TypesTask.fromMap(Map<String, dynamic> map) {
    taskId = map['taskId'];
    title= map['title'];
    target= map['target'];
    reward= map['reward'];
    punishment= map['punishment'];
    dateCreated= map['dateCreated'];
    allDays= map['allDays'];
    tag = map['tag'];
    holidayDays= map['holidayDays'];
    dayofftaken= map['dayofftaken'];
    isfine= map['isfine'];
    fine= double.parse(map['fine'].toString());
    supervisor= map['supervisor'];
    final checks = List.from(map['logs'] != null ? map['logs'] : []);
    logs = checks.map((item)=>TypesLog.fromMap(item)).toList();
    status= map['status'];
    tagInfo = map['tagInfo'] != null ? Tag.fromMap(map['tagInfo']) : null;
    currentStatus = map['currentStatus'];
    currentDay = map['currentDay'];
    preAllDays = map['preAllDays'];
    completedDay = map['completedDay'];
    haveSignDays = map['haveSignDays'];
    counter = map['counter'] ?? 0;
    count = map['count'] ?? 0;
    countTime = map['countTime'];
  }
}

abstract class TypesSupervisor {
  String nid;
  String nickName;
}

class TypesLog {
  // 打卡时间
  String checkTime;

  // 备注
  String remark;

  // 状态类型
  String type;
  
  // 计数
  int count;

  // 计数时间
  String changetime;

  // 评论
  List<TypesCommet> commet;
  TypesLog.fromMap(Map<String, dynamic> map) {
    checkTime = map['checkTime'];
    remark = map['remark'];
    type = map['type'];
    count = map['count'] ?? 0;
    changetime = map['changetime'];
  }
}


abstract class TypesCommet {
  // id
  String nid;

  // 昵称
  String nickName;

  // 评论时间
  String time;

  // 评论内容
  String commet;
}



class Tag {
  int tagId;

  String name;

  String color;
  
  Tag.fromMap(Map<String, dynamic> map) {
    tagId = map['tagId'];
    name = map['name'];
    color = map['color'];
  }
}

