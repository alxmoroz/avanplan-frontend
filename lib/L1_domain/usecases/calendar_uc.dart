// Copyright (c) 2024. Alexandr Moroz

import '../entities/calendar_source.dart';
import '../repositories/abs_calendar_repo.dart';

class CalendarUC {
  const CalendarUC({required this.calendarRepo});

  final AbstractCalendarRepo calendarRepo;

  Future<CalendarSource?> updateSource(CalendarSourceType type) async => await calendarRepo.updateSource(type);
  Future<Iterable<CalendarSource>> getSources() async => await calendarRepo.getSources();
}
