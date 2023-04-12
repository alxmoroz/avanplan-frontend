// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/member.dart';
import '../../L1_domain/entities/role.dart';
import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/task_source.dart';
import '../../L1_domain/entities/user.dart';
import '../../L1_domain/entities/workspace.dart';
import '../../L1_domain/entities_extensions/task_level.dart';
import '../../L1_domain/entities_extensions/task_members.dart';
import '../../L1_domain/entities_extensions/task_stats.dart';
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
  User? get _authUser => accountController.user;
  Workspace? get _ws => mainController.selectedWS;
  // Workspace? get _ws => mainController.wsForId(wsId);

  bool get hpWSProjectCreate => mainController.myWorkspaces.any((ws) => ws.hpProjectCreate);

  /// разрешения для текущего пользователя для РП, выбранной задачи или проекта
  Member? get _pm => projectMembers.firstWhereOrNull((m) => m.userId == _authUser?.id);

  bool get _hpProjectContentUpdate => _ws?.hpProjectContentUpdate == true;

  bool get _hpMemberUpdate => _pm?.hp('MEMBER_UPDATE') == true || _hpProjectContentUpdate;
  bool get _hpCreate => _pm?.hp('TASK_CREATE') == true || _hpProjectContentUpdate;
  bool get _hpUpdate => _pm?.hp('TASK_UPDATE') == true || _hpProjectContentUpdate;
  bool get _hpDelete => _pm?.hp('TASK_DELETE') == true || _hpProjectContentUpdate;

  /// доступные действия
  bool get _isLocal => !hasLink;
  bool get _isLocalProject => isProject && _isLocal;
  bool get _isLinkedProject => isProject && hasLink;

  bool get _canProjectCreate => isWorkspace && hpWSProjectCreate;
  bool get _canProjectUpdate => _isLocalProject && _ws?.hpProjectUpdate == true;
  bool get _canProjectDelete => _isLocalProject && _ws?.hpProjectDelete == true;
  bool get _canTaskCreate => !closed && _hpCreate && !hasLink;
  bool get _canTaskUpdate => !isWorkspace && _hpUpdate && !hasLink;
  bool get _canTaskDelete => _hpDelete && !hasLink;

  bool get canCreate => _canProjectCreate || _canTaskCreate;
  bool get canUpdate => _canProjectUpdate || _canTaskUpdate;
  bool get canDelete => _canProjectDelete || _canTaskDelete;
  bool get canImport => _canProjectCreate;
  bool get canRefresh => isWorkspace;
  bool get canReopen => closed && canUpdate && parent?.closed == false;
  bool get canClose => canUpdate && !closed && !hasLink;
  bool get canUnlink => _isLinkedProject && _ws?.hpProjectUpdate == true;
  bool get canUnwatch => _isLinkedProject && _ws?.hpProjectDelete == true;
  bool get canMembersRead => isProject;
  bool get canEditMembers => _hpMemberUpdate;

  bool get plMembersAdd => _ws?.plUsers == true;
  bool get plUnlink => _ws?.plUnlink == true;

  bool get _plProjects => _ws?.plProjects == true;
  bool get _plTasks => _ws?.plTasks == true;
  bool get plCreate => isWorkspace ? _plProjects : _plTasks;

  /// доступные роли для управления
  // https://redmine.moroz.team/issues/2518
  Iterable<Role> get allowedRoles => _ws?.roles ?? [];

  /// рекомендации, быстрые кнопки
  bool get shouldClose => canUpdate && state == TaskState.closable;
  bool get shouldCloseLeaf => canClose && (isTask || isSubtask) && isLeaf;
  bool get shouldAddSubtask =>
      canCreate &&
      isLeaf &&
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
        if (canCreate) TaskActionType.add,
        if (canUpdate) TaskActionType.edit,
        if (canClose) TaskActionType.close,
        if (canReopen) TaskActionType.reopen,
        if (canUnlink) TaskActionType.unlink,
        if (canUnwatch) TaskActionType.unwatch,
      ];

  void _updateParentTask() {
    if (parent != null) {
      final index = parent!.tasks.indexWhere((t) => t.id == id);
      if (index >= 0) {
        if (deleted) {
          parent!.tasks.removeAt(index);
        } else {
          parent!.tasks[index] = this;
        }
      }
    }
  }

  Iterable<TaskSource> allTss() {
    final tss = <TaskSource>[];
    for (Task subtask in tasks) {
      tss.addAll(subtask.allTss());
    }
    if (hasLink) {
      tss.add(taskSource!);
    }
    return tss;
  }

  void unlinkTaskTree() {
    for (Task subtask in tasks) {
      subtask.unlinkTaskTree();
    }
    if (hasLink) {
      taskSource?.keepConnection = false;
    }
  }

  void updateParents() {
    if (parent != null) {
      parent!.updateParents();
    }
    _updateParentTask();
  }
}
