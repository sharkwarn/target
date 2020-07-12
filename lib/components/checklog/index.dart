import 'package:flutter/material.dart';

class CheckLog extends StatelessWidget {
  const CheckLog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Card(
        child: Row(
          children: <Widget>[
            Icon(
              Icons.headset
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('小五'),
                Text('2020-07-08 12:12')
              ],
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(
                    Icons.comment
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}