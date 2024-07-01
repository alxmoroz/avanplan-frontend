// Copyright (c) 2024. Alexandr Moroz

import '../entities/calendar.dart';
import '../entities/calendar_source.dart';

abstract class AbstractCalendarRepo {
  Future<CalendarSource?> updateSource(CalendarSourceType type) async => throw UnimplementedError();
  Future<Iterable<CalendarSource>> getSources() async => throw UnimplementedError();
  Future<CalendarsEvents> getCalendarsEvents() async => throw UnimplementedError();
}
