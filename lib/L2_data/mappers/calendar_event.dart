// Copyright (c) 2024. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/calendar_event.dart';

extension CalendarEventMapper on CalendarEventGet {
  CalendarEvent get event => CalendarEvent(
        title: title,
        description: description ?? '',
        calendarId: calendarId,
        startDate: startDate.toLocal(),
        endDate: endDate.toLocal(),
        allDay: allDay ?? false,
        location: location ?? '',
      );
}
