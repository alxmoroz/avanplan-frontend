// Copyright (c) 2022. Alexandr Moroz

import 'package:intl/intl.dart';

import '../../L1_domain/entities/task.dart';

extension TaskLevel on Task {
  /// иерархия
  // bool get isProject => parent == null;
  // bool get isGoal => parent?.isProject == true;
  // bool get isTask => parent?.isGoal == true;
  // bool get isSubtask => parent?.isTask == true || parent?.isSubtask == true;

  int get level {
    int res = 1;
    if (parent != null) {
      res += parent?.level ?? 1;
    }
    return res;
  }

  String get _titleCode => {1: 'Project', 2: 'Goal', 3: 'Task'}[level] ?? 'Subtask';

  String get viewTitle => Intl.message(_titleCode, name: _titleCode);
}
