// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';

import '../entities_extensions/calendar_event.dart';
import '../entities_extensions/task_state.dart';
import 'base_entity.dart';
import 'calendar_event.dart';
import 'task.dart';

class NextTaskOrEvent implements Comparable {
  NextTaskOrEvent(this.date, this.item);
  final DateTime? date;
  final Titleable item;
  bool get hasDate => date != null;

  TaskState get state => item is Task ? (item as Task).leafState : (item as CalendarEvent).state;

  @override
  int compareTo(other) {
    int res = 0;

    if ((hasDate) || (other.hasDate)) {
      if (!hasDate) {
        res = 1;
      } else if (!other.hasDate) {
        res = -1;
      } else {
        res = date!.compareTo(other.date!);
      }
    }

    if (res == 0) {
      res = compareNatural(item.title, other.item.title);
    }

    return res;
  }
}
