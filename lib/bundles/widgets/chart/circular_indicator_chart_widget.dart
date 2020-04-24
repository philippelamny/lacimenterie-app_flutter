import 'dart:math';

import 'package:flutter/material.dart';

class CircularIndicatorChartWidget extends CustomPainter{

  double currentProgress;
  Color colorOuterCicle;
  Color colorCompleteArc;
  CircularIndicatorChartWidget(this.currentProgress, {this.colorOuterCicle, this.colorCompleteArc});
  
  @override
  void paint(Canvas canvas, Size size) {
    if (colorOuterCicle == null) {
      colorOuterCicle = Color.fromRGBO(221, 221, 221, 1);
    }

    if (colorCompleteArc == null) {
      colorCompleteArc = Colors.green;
    }

    //this is base circle
    Paint outerCircle = Paint()
        ..strokeWidth = 10
        ..color = colorOuterCicle
        ..style = PaintingStyle.stroke;

    Paint completeArc = Paint()
      ..strokeWidth = 10
      ..color = colorCompleteArc
      ..style = PaintingStyle.stroke
      ..strokeCap  = StrokeCap.round;

    Offset center = Offset(size.width/2, size.height/2);
    double radius = min(size.width/2,size.height/2) - 10;

    canvas.drawCircle(center, radius, outerCircle); // this draws main outer circle

    double angle = 2 * pi * (currentProgress/100);

    canvas.drawArc(Rect.fromCircle(center: center,radius: radius), -pi/2, angle, false, completeArc);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}