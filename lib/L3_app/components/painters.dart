// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

class TrianglePainter extends CustomPainter {
  TrianglePainter({required this.color})
      : _paint = Paint()
          ..color = color
          ..style = PaintingStyle.fill;
  final Paint _paint;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
        Path()
          ..moveTo(0, size.height)
          ..lineTo(size.width / 2, 0)
          ..lineTo(size.width, size.height)
          ..close(),
        _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class ArcPainter extends CustomPainter {
  ArcPainter({required this.color, required this.startAngle, required this.endAngle, this.strokeWidth = 2})
      : _paint = Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;
  final Paint _paint;

  final Color color;
  final double startAngle;
  final double endAngle;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawArc(
      Rect.fromLTWH(strokeWidth, strokeWidth, size.width - strokeWidth * 2, size.height - strokeWidth * 2),
      startAngle,
      endAngle,
      false,
      _paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
