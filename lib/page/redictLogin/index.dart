
/// 这是一个有状态组件，有状态组件必须由两部分构成。StatefulWidget 和 State

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../modal/login.dart';


class RedictLogin extends StatefulWidget {


  _RedictLogin createState() => _RedictLogin();
}


class _RedictLogin extends State<RedictLogin> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<LoginModal>(context, listen: false).changeStatus(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
      )
    );
  }
}
