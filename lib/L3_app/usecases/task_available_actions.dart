// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/member.dart';
import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/user.dart';
import '../../L1_domain/entities_extensions/task_members.dart';
import '../../L1_domain/entities_extensions/task_status.dart';
import '../extra/services.dart';
import '../presenters/task_stats.dart';
import '../presenters/task_transfer.dart';
import '../presenters/task_tree.dart';
import 'ws_available_actions.dart';

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
  bool get canUpdate => _isLocal && ((isProject && ws.hpProjectUpdate == true) || _hpUpdate);
  bool get canDelete => (isProject && ws.hpProjectDelete == true) || (_isLocal && _hpDelete);
  bool get canReopen => closed && canUpdate && (isProject || parent?.closed == false);
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
        TType.PROJECT,
        TType.GOAL,
      ].contains(type) &&
      canCreate &&
      !hasOpenedSubtasks &&
      !canCloseGroup;

  Iterable<TaskActionType> get actionTypes => [
        if (canClose) TaskActionType.close,
        if (canReopen) TaskActionType.reopen,
        if (canLocalExport) TaskActionType.localExport,
        if (wasImported && !linked) TaskActionType.go2source,
        if (canUnlink) TaskActionType.unlink,
        if (canDelete) TaskActionType.delete,
      ];
}
