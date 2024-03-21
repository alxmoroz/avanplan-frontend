// Copyright (c) 2024. Alexandr Moroz

import 'base_entity.dart';
import 'calendar_event.dart';

class Calendar extends Titleable {
  Calendar({
    super.id,
    required super.title,
    super.description,
  });
}

class CalendarsEvents {
  CalendarsEvents(this.calendars, this.events);
  final Iterable<Calendar> calendars;
  final Iterable<CalendarEvent> events;
}
