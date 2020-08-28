import 'package:flutter/material.dart';

class BorderBottom extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // 路径
    var path = Path();
    // 设置路径的开始点
    // path.lineTo(0, 0);

    int i = 0;
    int count = 51;
    double x = size.width / count;
    while (i <= count) {
      path.moveTo(x * i, 0);
      path.lineTo(x * (i + 1), 0);
      path.lineTo(x * (i + 1), 6);
      path.lineTo(x * i, 6);
      path.lineTo(x * i, 0);
      i = i + 2;
    }

    // 设置路径的结束点
    // path.lineTo(size.width, 10);

    // 返回路径
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
