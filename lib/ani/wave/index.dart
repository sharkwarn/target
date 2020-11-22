import 'package:flutter/material.dart';


class AniWave extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _AniWave();
  }
}

class _AniWave extends State<AniWave> with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation<double> animation;
  Animation<Color> animationColor;
  
  @override
  void initState() {
    super.initState();
    // 创建 AnimationController 对象
    controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 2000)
    );
    // 通过 Tween 对象 创建 Animation 对象
    animation = Tween(begin: 50.0, end: 200.0).animate(controller)
      ..addListener(() {
        // 注意：这句不能少，否则 widget 不会重绘，也就看不到动画效果
        setState(() {});
      });
    animationColor = ColorTween(begin: Colors.red, end: Colors.blue).animate(controller)
      ..addListener(() {
        // 注意：这句不能少，否则 widget 不会重绘，也就看不到动画效果
        setState(() {});
      });
    // 执行动画
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    print(animationColor);
    return Container(
      // 获取动画的值赋给 widget 的宽高
      width: animation.value,
      height: animation.value,
      decoration: BoxDecoration(
          color: animationColor.value
      ),
    );
  }

  @override
  void dispose() {
    // 资源释放
    controller.dispose();
    super.dispose();
  }
}