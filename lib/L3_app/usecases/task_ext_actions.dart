// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/member.dart';
import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/task_source.dart';
import '../../L1_domain/entities/user.dart';
import '../../L1_domain/entities_extensions/task_level.dart';
import '../../L1_domain/entities_extensions/task_members.dart';
import '../../L1_domain/entities_extensions/task_stats.dart';
import '../../L1_domain/entities_extensions/task_status_ext.dart';
import '../extra/services.dart';
import 'ws_ext_actions.dart';

enum TaskActionType {
  close,
  reopen,
  localExport,
  go2source,
  unlink,
  delete,
}

extension TaskActionsExt on Task {
  User? get _authUser => accountController.user;

  /// разрешения для текущего пользователя для РП, выбранной задачи или проекта
  Member? get me => projectMembers.firstWhereOrNull((m) => m.userId == _authUser?.id);

  bool get _hpMemberUpdate => me?.hp('MEMBER_UPDATE') == true || ws.hpProjectContentUpdate;
  bool get _hpCreate => me?.hp('TASK_CREATE') == true || ws.hpProjectContentUpdate;
  bool get _hpUpdate => me?.hp('TASK_UPDATE') == true || ws.hpProjectContentUpdate;
  bool get _hpDelete => me?.hp('TASK_DELETE') == true || ws.hpProjectContentUpdate;

  /// доступные действия
  bool get _isLocal => !linked;
  bool get isLinkedProject => isProject && !_isLocal;

  bool get canCreate => _isLocal && !closed && _hpCreate;
  bool get canUpdate => !isRoot && _isLocal && ((isProject && ws.hpProjectUpdate == true) || _hpUpdate);
  bool get canDelete => (isProject && ws.hpProjectDelete == true) || (_isLocal && _hpDelete);
  bool get canRefresh => isRoot;
  bool get canReopen => closed && canUpdate && parent?.closed == false;
  bool get canClose => canUpdate && !closed;
  bool get canUnlink => isLinkedProject && ws.hpProjectUpdate == true;
  bool get canMembersRead => isProject;
  bool get canEditMembers => _hpMemberUpdate;
  bool get canSetStatus => statuses.isNotEmpty && canUpdate && isLeaf;
  bool get canCloseGroup => canClose && state == TaskState.CLOSABLE;
  bool get canEstimate => canUpdate && ws.estimateValues.isNotEmpty && isLeaf;
  bool get canAssign => canUpdate && activeMembers.isNotEmpty;
  bool get canLocalExport => canUpdate && goalsForLocalExport.isNotEmpty;
  bool get canLocalImport => canUpdate && goalsForLocalImport.isNotEmpty;
  bool get canComment => !isProject && canUpdate;

  /// рекомендации, быстрые кнопки
  bool get shouldAddSubtask =>
      [
        TaskLevel.project,
        TaskLevel.goal,
      ].contains(level) &&
      canCreate &&
      !hasOpenedSubtasks;

  Iterable<TaskActionType> get actionTypes => [
        if (canClose) TaskActionType.close,
        if (canReopen) TaskActionType.reopen,
        if (canLocalExport) TaskActionType.localExport,
        if (wasImported && !linked) TaskActionType.go2source,
        if (canUnlink) TaskActionType.unlink,
        if (canDelete) TaskActionType.delete,
      ];

  void _updateParentTask() {
    if (parent != null) {
      final index = parent!.tasks.indexWhere((t) => t.id == id);
      if (index >= 0) {
        if (removed) {
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
    if (linked) {
      tss.add(taskSource!);
    }
    return tss;
  }

  void unlinkTaskTree() {
    for (Task subtask in tasks) {
      subtask.unlinkTaskTree();
    }
    if (linked) {
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
