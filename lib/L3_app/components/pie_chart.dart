// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

import 'package:flutter/cupertino.dart';

import 'colors.dart';
import 'colors_base.dart';
import 'constants.dart';

class MTPieChartData {
  const MTPieChartData(
    this.value, {
    this.start,
    this.color,
    this.radius,
    this.strokeWidth,
    this.strokeCap,
  });
  final double value;
  final double? start;
  final Color? color;
  final double? radius;
  final double? strokeWidth;
  final StrokeCap? strokeCap;
}

class _PieChartPainter extends CustomPainter {
  _PieChartPainter({
    required this.data,
    required this.radius,
    required this.startAngle,
    required this.sweepAngle,
    required this.context,
    this.totalValue,
    this.strokeWidth,
  });
  List<MTPieChartData> data;
  final BuildContext context;
  final double radius;
  final double startAngle;
  final double sweepAngle;
  final double? totalValue;
  final double? strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final _totalSum = data.fold<double>(0, (res, arc) => res + (arc.value > 0 ? arc.value : 0));
    final _totalValue = totalValue ?? _totalSum;
    double _startAngle = startAngle;
    final _dA = _totalValue > 0 ? (sweepAngle / _totalValue) : 0;

    for (final arcData in data) {
      final _sweepAngle = arcData.value * _dA;
      _startAngle = arcData.start != null ? (startAngle + arcData.start! * _dA) : _startAngle;
      final _strokeWidth = arcData.strokeWidth ?? strokeWidth ?? P;

      final _paint = Paint()
        ..color = (arcData.color ?? b2Color).resolve(context)
        ..strokeWidth = _strokeWidth
        ..strokeCap = arcData.strokeCap ?? StrokeCap.round
        ..style = PaintingStyle.stroke;

      canvas.drawArc(
        Rect.fromLTWH(_strokeWidth / 2, _strokeWidth / 2, size.width - _strokeWidth, size.height - _strokeWidth),
        _startAngle * pi / 180,
        _sweepAngle * pi / 180,
        false,
        _paint,
      );

      _startAngle += _sweepAngle;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class MTPieChart extends StatelessWidget {
  const MTPieChart({
    required this.data,
    required this.radius,
    this.startAngle = -90,
    this.sweepAngle = 360,
    this.strokeWidth,
    this.totalValue,
    this.strokeCap,
  });
  final List<MTPieChartData> data;
  final double radius;
  final double startAngle;
  final double sweepAngle;
  final double? totalValue;
  final double? strokeWidth;
  final StrokeCap? strokeCap;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _PieChartPainter(
        context: context,
        data: data,
        radius: radius,
        startAngle: startAngle,
        sweepAngle: sweepAngle,
        totalValue: totalValue,
        strokeWidth: strokeWidth,
      ),
      child: Container(width: radius * 2, height: radius * 2),
    );
  }
}
