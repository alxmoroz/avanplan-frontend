// Copyright (c) 2022. Alexandr Moroz

import 'task.dart';
import 'task_ext_level.dart';
import 'task_ext_state.dart';

enum TaskActionType {
  add,
  edit,
  import,
  unlink,
  unwatch,
}

extension TaskActionsExt on Task {
  /// доступные действия
  bool get canAdd => isWorkspace || !(closed || hasLink);
  bool get canEdit => !(isWorkspace || hasLink);
  bool get canImport => isWorkspace;
  bool get canUnlink => hasLink;
  bool get canUnwatch => hasLink;
  bool get canRefresh => isWorkspace;

  List<TaskActionType> get actionTypes {
    final res = <TaskActionType>[];
    if (canAdd) {
      res.add(TaskActionType.add);
    }
    if (canEdit) {
      res.add(TaskActionType.edit);
    }
    if (canImport) {
      res.add(TaskActionType.import);
    }
    if (canUnlink) {
      res.add(TaskActionType.unlink);
    }
    if (canUnwatch) {
      res.add(TaskActionType.unwatch);
    }
    return res;
  }
}
