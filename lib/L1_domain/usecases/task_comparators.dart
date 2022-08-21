// Copyright (c) 2022. Alexandr Moroz

import '../entities/task.dart';
import '../entities/task_ext_state.dart';

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
    res = t1.title.compareTo(t2.title);
  }

  return res;
}
