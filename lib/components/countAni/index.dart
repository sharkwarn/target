
import 'package:flutter/material.dart';


class CountAni extends StatefulWidget {

  CountAni({
    Key key,
    this.callback
  }) : super(key: key);

  final Function callback;

  _CountAni createState() => _CountAni();
}

class _CountAni extends State<CountAni> with SingleTickerProviderStateMixin {


  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
      duration: const Duration(milliseconds: 60000),
      vsync: this
    );
    animation = new Tween(begin: 60.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {
        });
      })
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
          widget.callback();
        }
      });
    controller.forward();
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }

    @override
  Widget build(BuildContext context) {
    return Text(
      (animation.value~/1).toString(),
      style: TextStyle(
        color: Colors.white,
        fontSize: 16
      ),
    );
  }

}