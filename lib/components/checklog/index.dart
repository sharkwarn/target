import 'package:flutter/material.dart';
import '../timepipeline/index.dart';
import '../../utils/date.dart';

class CheckLog extends StatelessWidget {
  CheckLog({
    Key key,
    this.checkTime,
    this.remark,
    this.isVacation
  }) : super(key: key);

  final String checkTime;
  final String remark;
  final bool isVacation;

  @override
  Widget build(BuildContext context) {
    final String nowTime = DateMoment.getDate(checkTime);
    final List<String> date = nowTime.split(' ');
    final List<String> time = date[1].split('.');
    return TimePipeline(
      date: date[0],
      time: time[0],
      status: isVacation ? 'warn' : 'success',
      title: isVacation ? '休假' : '打卡',
      remark: remark,
    );
  }
}