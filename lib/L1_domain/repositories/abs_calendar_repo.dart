// Copyright (c) 2024. Alexandr Moroz

import '../entities/calendar_source.dart';

abstract class AbstractCalendarRepo {
  Future<CalendarSource?> updateSource(CalendarSourceType type);
  Future<Iterable<CalendarSource>> getSources();
}
