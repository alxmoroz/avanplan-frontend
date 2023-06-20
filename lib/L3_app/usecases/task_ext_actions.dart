// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/member.dart';
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
  close,
  reopen,
  unlink,
  delete,
}

extension TaskActionsExt on Task {
  User? get _authUser => accountController.user;

  Workspace get ws => mainController.wsForId(wsId);

  bool get hpWSProjectCreate => mainController.workspaces.any((ws) => ws.hpProjectCreate);

  /// разрешения для текущего пользователя для РП, выбранной задачи или проекта
  Member? get _pm => projectMembers.firstWhereOrNull((m) => m.userId == _authUser?.id);

  bool get _hpMemberUpdate => _pm?.hp('MEMBER_UPDATE') == true || ws.hpProjectContentUpdate;
  bool get _hpCreate => _pm?.hp('TASK_CREATE') == true || ws.hpProjectContentUpdate;
  bool get _hpUpdate => _pm?.hp('TASK_UPDATE') == true || ws.hpProjectContentUpdate;
  bool get _hpDelete => _pm?.hp('TASK_DELETE') == true || ws.hpProjectContentUpdate;

  /// доступные действия
  bool get _isLocal => !hasLink;
  bool get _isLocalProject => isProject && _isLocal;
  bool get _isLinkedProject => isProject && !_isLocal;

  bool get _canProjectUpdate => _isLocalProject && ws.hpProjectUpdate == true;
  bool get _canProjectDelete => _isLocalProject && ws.hpProjectDelete == true;
  bool get _canTaskCreate => !closed && _hpCreate && _isLocal;
  bool get _canTaskUpdate => !isRoot && _hpUpdate && _isLocal;
  bool get _canTaskDelete => _hpDelete && _isLocal;

  bool get canCreate => _canTaskCreate;
  bool get canUpdate => _canProjectUpdate || _canTaskUpdate;
  bool get canDelete => _canProjectDelete || _canTaskDelete;
  bool get canRefresh => isRoot;
  bool get canReopen => closed && canUpdate && parent?.closed == false;
  bool get canClose => canUpdate && !closed;
  bool get canUnlink => _isLinkedProject && ws.hpProjectUpdate == true;
  bool get canMembersRead => isProject;
  bool get canEditMembers => _hpMemberUpdate;
  bool get canSetStatus => ws.statuses.isNotEmpty && canUpdate && isLeaf;
  bool get canCloseGroup => canClose && state == TaskState.closable;
  bool get canEstimate => canUpdate && ws.estimateValues.isNotEmpty && isLeaf;
  bool get canAssign => canUpdate && activeMembers.isNotEmpty;

  /// рекомендации, быстрые кнопки
  bool get shouldAddSubtask =>
      canCreate &&
      [
        TaskLevel.project,
        TaskLevel.goal,
      ].contains(level);

  Iterable<TaskActionType> get actionTypes => [
        if (canClose) TaskActionType.close,
        if (canReopen) TaskActionType.reopen,
        if (canUnlink) TaskActionType.unlink,
        if (canDelete) TaskActionType.delete,
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
