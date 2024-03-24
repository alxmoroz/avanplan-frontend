// Copyright (c) 2024. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/calendar_event.dart';

extension CalendarEventMapper on CalendarEventGet {
  CalendarEvent get event {
    final rAllDay = allDay ?? false;
    final rEndDate = (rAllDay ? endDate.subtract(const Duration(seconds: 1)) : endDate).toLocal();

    return CalendarEvent(
      title: title,
      description: description ?? '',
      calendarId: calendarId,
      startDate: startDate.toLocal(),
      endDate: rEndDate,
      allDay: rAllDay,
      location: location ?? '',
      sourceLink: sourceLink ?? '',
      sourceCode: sourceCode ?? '',
    );
  }
}
