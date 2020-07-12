


class TypesTask {

  // id
  int id;

  // 任务目标
  String title;

  // 目的
  String target;

  // 创建日期
  String dateCreated;

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
  List<TypesCheckLog> checklogs;

  // 状态
  String status;

  TypesTask.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title= map['title'];
    target= map['target'];
    dateCreated= map['dateCreated'];
    allDays= map['allDays'];
    holidayDays= map['holidayDays'];
    dayofftaken= map['dayofftaken'];
    isfine= map['isfine'];
    fine= map['fine'];
    supervisor= map['supervisor'];
    final checks = List.from(map['checklogs']);
    checklogs= checks.map((item)=>TypesCheckLog.fromMap(item)).toList();
    status= map['status'];
  }
}

abstract class TypesSupervisor {
  String nid;
  String nickName;
}

class TypesCheckLog {
  // 打卡时间
  String checkTime;

  // 备注
  String remark;

  // 是否休假
  bool isVacation;

  // 上传照片
  List<String> imgs;

  // 评论
  List<TypesCommet> commet;
  TypesCheckLog.fromMap(Map<String, dynamic> map) {
    checkTime = map['checkTime'];
    remark = map['remark'];
    isVacation = map['isVacation'];
    imgs = map['imgs'];
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