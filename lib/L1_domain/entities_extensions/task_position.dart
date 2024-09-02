// Copyright (c) 2023. Alexandr Moroz

import '../entities/task.dart';

extension TaskPositionExtension on Task {
  int compareByPosition(Task t2) {
    int res = 0;
    if (position?.isNotEmpty == true && t2.position?.isNotEmpty == true) {
      res = position!.compareTo(t2.position!);
    }
    if (res == 0) {
      res = compareTo(t2);
    }
    return res;
  }
}
