// Copyright (c) 2022. Alexandr Moroz

import 'task.dart';
import 'task_ext_level.dart';
import 'task_ext_state.dart';
import 'task_source.dart';

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
  bool get canReopen => canEdit && (isClosable || closed);

  bool get shouldAddSubtask =>
      !hasSubtasks &&
      canAdd &&
      [
        TaskLevel.project,
        TaskLevel.goal,
      ].contains(level);

  List<TaskActionType> get actionTypes {
    final res = <TaskActionType>[];
    if (canImport) {
      res.add(TaskActionType.import);
    }
    if (canAdd) {
      res.add(TaskActionType.add);
    }
    if (canEdit) {
      res.add(TaskActionType.edit);
    }
    if (isProject && hasLink) {
      res.add(TaskActionType.go2source);
      res.add(TaskActionType.unlink);
      res.add(TaskActionType.unwatch);
    }
    return res;
  }

  void _updateParentTask() {
    if (parent != null) {
      final index = parent!.tasks.indexWhere((t) => t.id == id);
      if (index >= 0) {
        if (deleted) {
          parent!.tasks.removeAt(index);
        } else {
          //TODO: проверить необходимость в copy
          parent!.tasks[index] = copy();
        }
      }
    }
  }

  // TODO: в юзкейс
  Iterable<TaskSource> unlinkTaskTree() {
    final tss = <TaskSource>[];
    for (Task subtask in tasks) {
      tss.addAll(subtask.unlinkTaskTree());
    }
    if (hasLink) {
      taskSource?.keepConnection = false;
      tss.add(taskSource!);
    }
    return tss;
  }

  void updateParents() {
    if (parent != null) {
      parent!.updateParents();
    }
    _updateParentTask();
  }
}
