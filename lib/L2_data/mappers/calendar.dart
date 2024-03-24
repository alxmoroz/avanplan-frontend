// Copyright (c) 2024. Alexandr Moroz

import 'dart:ui';

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/calendar.dart';

Color? _parseColor(String? colorStr) => colorStr != null ? Color(int.parse(colorStr.replaceAll('#', 'bb'), radix: 16)) : null;

extension CalendarMapper on CalendarGet {
  Calendar get calendar => Calendar(
        id: id,
        title: title,
        description: description ?? '',
        calendarSourceId: calendarSourceId,
        sourceCode: sourceCode,
        enabled: enabled ?? true,
        bgColor: _parseColor(backgroundColor),
        fgColor: _parseColor(foregroundColor),
      );
}
