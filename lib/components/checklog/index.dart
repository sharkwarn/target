import 'package:flutter/material.dart';
import '../timepipeline/index.dart';

class CheckLog extends StatelessWidget {
  CheckLog({
    Key key,
    this.checkTime,
    this.remark,
    this.type,
    this.count,
    this.changetime
  }) : super(key: key);

  final String checkTime;
  final String remark;
  final String type;
  final int count;
  final String changetime;

  @override
  Widget build(BuildContext context) {
    final List<String> date = checkTime.split(' ');
    return TimePipeline(
      date: date[0],
      time: date[1],
      status: type,
      remark: remark,
      count: count,
      changetime: changetime
    );
  }
}