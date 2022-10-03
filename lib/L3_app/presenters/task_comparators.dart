// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/usecases/task_ext_state.dart';

// TODO: найти подходящее место
int sortByDateAsc(Task t1, Task t2) {
  int res = 0;
  if (t1.hasDueDate || t2.hasDueDate) {
    if (!t1.hasDueDate) {
      res = 1;
    } else if (!t2.hasDueDate) {
      res = -1;
    } else {
      res = t1.dueDate!.compareTo(t2.dueDate!);
    }
  }

  if (res == 0) {
    res = compareNatural(t1.title, t2.title);
  }

  return res;
}
