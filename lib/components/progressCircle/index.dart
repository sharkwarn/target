import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ProgressCircle extends CustomPainter {
  ProgressCircle({Key key, this.width, this.height}) : super();

  final double width;

  final double height;

  @override
  paint(Canvas canvas, Size size) {
    drawline(canvas, 30);
    drawline(canvas, 70);
    drawline(canvas, 110);
    drawline(canvas, 150);
    drawCircleLine(canvas);
    drawLargeArc(canvas);
    // circle(canvas);
  }

  drawline(Canvas canvas, double single) {
    final double maxR = height;
    final double minR = 120;
    final double startY = height - maxR * sin(single * pi / 180);
    final double startX = width / 2 - maxR * cos(single * pi / 180);
    final double endY = height - minR * sin(single * pi / 180);
    final double endX = width / 2 - minR * cos(single * pi / 180);
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Colors.green
      ..shader = ui.Gradient.sweep(Offset(100, 100), [Colors.red, Colors.blue]);
    canvas.drawLine(new Offset(startX, startY), new Offset(endX, endY), paint);
  }

  drawCircleLine(Canvas canvas) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..color = Colors.green;
    canvas.drawArc(
        Rect.fromCircle(center: Offset(width / 2, height), radius: 120),
        -30 * (pi / 180),
        -120 * (pi / 180),
        false,
        paint);
  }

  drawLargeArc(Canvas canvas) {
    final Gradient gradient = new SweepGradient(
      endAngle: 320 * (pi / 180),
      startAngle: 210 * (pi / 180),
      colors: [
        Colors.green,
        Colors.red,
      ],
    );
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round
      ..color = Colors.green
      ..shader = gradient.createShader(Rect.fromCircle(center: Offset(width / 2, height), radius: 150));
    canvas.drawArc(
        Rect.fromCircle(center: Offset(width / 2, height), radius: 150),
        -30 * (pi / 180),
        -120 * (pi / 180),
        false,
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
