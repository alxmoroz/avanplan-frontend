// Copyright (c) 2024. Alexandr Moroz

import '../entities/calendar.dart';
import '../entities/calendar_source.dart';

abstract class AbstractMyCalendarRepo {
  Future<CalendarSource?> updateSource(CalendarSourceType type);
  Future<Iterable<CalendarSource>> getSources();
  Future<CalendarsEvents> getCalendarsEvents();
}
