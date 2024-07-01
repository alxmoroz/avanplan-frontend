// Copyright (c) 2024. Alexandr Moroz

import '../entities/calendar.dart';
import '../entities/calendar_source.dart';
import '../repositories/abs_my_calendar_repo.dart';

class MyCalendarUC {
  const MyCalendarUC(this.repo);

  final AbstractCalendarRepo repo;

  Future<CalendarSource?> updateSource(CalendarSourceType type) async => await repo.updateSource(type);
  Future<Iterable<CalendarSource>> getSources() async => await repo.getSources();
  Future<CalendarsEvents> getCalendarsEvents() async => await repo.getCalendarsEvents();
}
