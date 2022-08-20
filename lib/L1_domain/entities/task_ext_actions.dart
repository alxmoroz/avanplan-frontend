// Copyright (c) 2022. Alexandr Moroz

import 'task.dart';
import 'task_ext_level.dart';
import 'task_ext_state.dart';

enum TaskActionType {
  add,
  edit,
  import,
  go2source,
  unlink,
  unwatch,
}

extension TaskActionsExt on Task {
  /// доступные действия
  bool get canAdd => isWorkspace || !(closed || hasLink);
  bool get canEdit => !(isWorkspace || hasLink);
  bool get canImport => isWorkspace;
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
    if (hasLink) {
      res.add(TaskActionType.go2source);
      res.add(TaskActionType.unlink);
      res.add(TaskActionType.unwatch);
    }
    return res;
  }
}
