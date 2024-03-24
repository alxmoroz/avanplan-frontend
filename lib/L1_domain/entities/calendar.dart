// Copyright (c) 2024. Alexandr Moroz

import 'dart:ui';

import 'base_entity.dart';
import 'calendar_event.dart';

class Calendar extends Titleable {
  Calendar({
    super.id,
    required super.title,
    super.description,
    required this.calendarSourceId,
    required this.sourceCode,
    required this.enabled,
    required this.bgColor,
    required this.fgColor,
  });

  final int calendarSourceId;
  final String sourceCode;

  bool enabled;
  Color? bgColor;
  Color? fgColor;

  bool get hasColors => bgColor != null && fgColor != null;
}

class CalendarsEvents {
  CalendarsEvents(this.calendars, this.events);
  final Iterable<Calendar> calendars;
  final Iterable<CalendarEvent> events;
}
