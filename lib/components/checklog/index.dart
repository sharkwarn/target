import 'package:flutter/material.dart';
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
    return Container(
      color: Colors.green,
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Card(
        child: Row(
          children: <Widget>[
            Icon(
              isVacation ? Icons.sentiment_very_dissatisfied : Icons.sentiment_very_satisfied,
              color: isVacation ? Colors.red : Colors.green 
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(DateMoment.getDate(checkTime)),
                Text(remark)
              ],
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}