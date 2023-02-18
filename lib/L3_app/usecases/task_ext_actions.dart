// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/task_source.dart';
import '../../L1_domain/entities/user.dart';
import '../../L1_domain/usecases/task_ext_level.dart';
import '../../L1_domain/usecases/task_ext_members.dart';
import '../../L1_domain/usecases/task_ext_state.dart';
import '../extra/services.dart';
import 'ws_ext_actions.dart';

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
  /// разрешения для текущего пользователя для выбранной задачи или проекта
  User? get _user => accountController.user;

  bool get _hpProjectsEdit => projectWs?.canProjectsEdit == true;

  Iterable<String> get _tP => projectMembers.firstWhereOrNull((m) => m.userId == _user?.id)?.permissions ?? [];
  bool get _hpMembersView => _tP.contains('MEMBERS_VIEW') || _hpProjectsEdit;
  bool get _hpMembersEdit => _tP.contains('MEMBERS_EDIT') || _hpProjectsEdit;
  // bool get _hpView => _tP.contains('TASKS_VIEW') || _hpEditProjects;
  bool get _hpEdit => _tP.contains('TASKS_EDIT') || _hpProjectsEdit;
  // bool get _hpRolesEdit => _tP.contains('ROLES_EDIT') || _hpEditProjects;

  bool get hasLink => taskSource?.keepConnection == true;

  /// доступные действия

  bool get rootCanEditProjects => isWorkspace && mainController.canEditAnyWS;

  bool get canAdd => rootCanEditProjects || (!closed && canEdit);
  bool get canEdit => _hpEdit && !hasLink;
  bool get canImport => rootCanEditProjects;
  bool get canRefresh => isWorkspace;
  bool get canReopen => canEdit && closed && parent?.closed == false;
  bool get canClose => canEdit && !closed;
  bool get canViewMembers => members.isNotEmpty && _hpMembersView;
  bool get canEditMembers => canEdit && _hpMembersEdit;

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
