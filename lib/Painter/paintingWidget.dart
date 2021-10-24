// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Signature extends CustomPainter {
  final List points;
  final List<Color> colr;
  Signature({required this.points, required this.colr});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();

    for (int y = 0; y <= points.length - 1; y++) {
      /// The Paint to use for the following particular lines
      paint
      ..color = colr.elementAt(y)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10.0;      
      /// a single line
      for (int i = 0; i < points[y].length - 1; i++) {
        if (points[y][i] != null && points[y][i + 1] != null) {
          canvas.drawLine(points[y][i], points[y][i + 1], paint);
        }
      }
    }

    // drawLatestLines(points[points.length-1], canvas: canvas, paint: paint);
  }

  @override
  bool shouldRepaint(Signature oldDelegate) => true;
}
