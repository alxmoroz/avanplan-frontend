// Copyright (c) 2023. Alexandr Moroz

import '../entities/calendar_event.dart';
import '../entities/task.dart';
import '../utils/dates.dart';

extension CEExtension on CalendarEvent {
  TaskState get state => startDate.isBefore(today)
      ? TaskState.OVERDUE
      : yesterday.isBefore(startDate) && startDate.isBefore(tomorrow)
          ? TaskState.TODAY
          : today.isBefore(startDate) && startDate.isBefore(nextWeek)
              ? TaskState.THIS_WEEK
              : TaskState.FUTURE_DATE;

  int get days => endDate.difference(startDate).inDays;
}
