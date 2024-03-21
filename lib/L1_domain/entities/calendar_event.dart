// Copyright (c) 2024. Alexandr Moroz

import 'base_entity.dart';

class CalendarEvent extends Titleable {
  CalendarEvent({
    super.id,
    required super.title,
    super.description,
    required this.calendarId,
    required this.startDate,
    required this.endDate,
    required this.allDay,
    required this.location,
  });

  final int calendarId;

  DateTime startDate;
  DateTime endDate;
  bool allDay;
  String location;
}
