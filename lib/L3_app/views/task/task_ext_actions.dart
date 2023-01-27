// Copyright (c) 2022. Alexandr Moroz

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/task_source.dart';
import '../../../L1_domain/usecases/task_ext_level.dart';
import '../../../L1_domain/usecases/task_ext_state.dart';
import '../../extra/services.dart';

enum TaskActionType {
  add,
  edit,
  close,
  reopen,
  import_gitlab,
  import_jira,
  import_redmine,
  go2source,
  unlink,
  unwatch,
}

extension TaskActionsExt on Task {
  bool get hasLink => taskSource?.keepConnection == true;

  // TODO: учесть в RDAC

  /// доступные действия
  bool get canAdd => isWorkspace || !(closed || hasLink);
  bool get canEdit => !(isWorkspace || hasLink);
  bool get canImport => isWorkspace;
  bool get canRefresh => isWorkspace;
  bool get canReopen => canEdit && closed && parent?.closed == false;
  bool get canClose => canEdit && !closed;

  /// рекомендации, быстрые кнопки
  bool get shouldClose => canEdit && state == TaskState.closable;
  bool get shouldCloseLeaf => canClose && (isTask || isSubtask) && !hasSubtasks;
  bool get shouldAddSubtask =>
      canAdd &&
      !hasSubtasks &&
      [
        TaskLevel.project,
        TaskLevel.goal,
      ].contains(level);

  Iterable<TaskActionType> get actionTypes => [
        if (canImport) ...[
          if (refsController.hasStGitlab) TaskActionType.import_gitlab,
          if (refsController.hasStJira) TaskActionType.import_jira,
          if (refsController.hasStRedmine) TaskActionType.import_redmine,
        ],
        if (canAdd) TaskActionType.add,
        if (canEdit) TaskActionType.edit,
        if (canClose) TaskActionType.close,
        if (canReopen) TaskActionType.reopen,
        if (isProject && hasLink) ...[
          // TaskActionType.go2source,
          TaskActionType.unlink,
          TaskActionType.unwatch,
        ]
      ];

  void _updateParentTask() {
    if (parent != null) {
      final index = parent!.tasks.indexWhere((t) => t.id == id);
      if (index >= 0) {
        if (deleted) {
          parent!.tasks.removeAt(index);
        } else {
          //TODO: проверить необходимость в copy
          parent!.tasks[index] = this;
        }
      }
    }
  }

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
