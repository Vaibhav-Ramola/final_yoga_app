import 'dart:math';

import 'package:flutter/material.dart';

import '../models/landmark.dart';

class PaintStickMan extends CustomPainter {
  final List<Landmark> landmarks;
  PaintStickMan({
    required this.landmarks,
  });
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final headPoint = Offset(
      landmarks[0].x * size.width,
      landmarks[0].y * size.height,
    );
    // final chestPoint = Offset(
    //   (landmarks[6].x + landmarks[5].x) / 2 * size.width,
    //   (landmarks[6].y + landmarks[5].y) / 2 * size.height,
    // );
    final leftShoulderPoint = Offset(
      landmarks[6].x * size.width,
      landmarks[6].y * size.height,
    );
    final rightShoulderPoint = Offset(
      landmarks[5].x * size.width,
      landmarks[5].y * size.height,
    );
    final leftElboPoint = Offset(
      landmarks[8].x * size.width,
      landmarks[8].y * size.height,
    );
    final rightElboPoint = Offset(
      landmarks[7].x * size.width,
      landmarks[7].y * size.height,
    );
    final leftHandPoint = Offset(
      landmarks[10].x * size.width,
      landmarks[10].y * size.height,
    );
    final rightHandPoint = Offset(
      landmarks[9].x * size.width,
      landmarks[9].y * size.height,
    );
    // final hipPoint = Offset(
    //   (landmarks[12].x + landmarks[11].x) / 2 * size.width,
    //   (landmarks[12].y + landmarks[11].y) / 2 * size.height,
    // );
    final leftHipPoint = Offset(
      landmarks[12].x * size.width,
      landmarks[12].y * size.height,
    );
    final rightHipPoint = Offset(
      landmarks[11].x * size.width,
      landmarks[11].y * size.height,
    );
    final leftKneePoint = Offset(
      landmarks[14].x * size.width,
      landmarks[14].y * size.height,
    );
    final rightKneePoint = Offset(
      landmarks[13].x * size.width,
      landmarks[13].y * size.height,
    );
    final leftFootPoint = Offset(
      landmarks[16].x * size.width,
      landmarks[16].y * size.height,
    );
    final rightFootPoint = Offset(
      landmarks[15].x * size.width,
      landmarks[15].y * size.height,
    );
    // final radius = sqrt((landmarks[4].x - landmarks[0].x) *
    //             (landmarks[4].x - landmarks[0].x) +
    //         (landmarks[4].y - landmarks[0].y) *
    //             (landmarks[4].y - landmarks[0].y)) *
    //     size.shortestSide;
    // defining the paint
    final headPaint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;
    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;
    // drawing the canvas
    canvas.drawCircle(
      headPoint,
      8,
      headPaint,
    );
    canvas.drawLine(headPoint, rightShoulderPoint, paint);
    canvas.drawLine(headPoint, leftShoulderPoint, paint);
    canvas.drawLine(leftShoulderPoint, rightShoulderPoint, paint);
    canvas.drawLine(leftShoulderPoint, leftElboPoint, paint);
    canvas.drawLine(leftElboPoint, leftHandPoint, paint);
    canvas.drawLine(rightShoulderPoint, rightElboPoint, paint);
    canvas.drawLine(rightElboPoint, rightHandPoint, paint);
    canvas.drawLine(leftShoulderPoint, leftHipPoint, paint);
    canvas.drawLine(rightShoulderPoint, rightHipPoint, paint);
    canvas.drawLine(rightHipPoint, leftHipPoint, paint);
    canvas.drawLine(leftHipPoint, leftKneePoint, paint);
    canvas.drawLine(leftKneePoint, leftFootPoint, paint);
    canvas.drawLine(rightHipPoint, rightKneePoint, paint);
    canvas.drawLine(rightKneePoint, rightFootPoint, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
