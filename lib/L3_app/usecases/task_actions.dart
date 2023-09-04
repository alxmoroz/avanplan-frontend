// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/member.dart';
import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/user.dart';
import '../../L1_domain/entities_extensions/task_members.dart';
import '../../L1_domain/entities_extensions/task_stats.dart';
import '../../L1_domain/entities_extensions/task_status.dart';
import '../../L1_domain/entities_extensions/task_tree.dart';
import '../extra/services.dart';
import '../presenters/task_transfer.dart';
import '../presenters/task_tree.dart';
import 'ws_actions.dart';

enum TaskActionType {
  close,
  reopen,
  localExport,
  go2source,
  unlink,
  delete,
}

extension TaskActionsUC on Task {
  User? get _authUser => accountController.user;

  /// разрешения для текущего пользователя для РП, выбранной задачи или проекта
  Member? get me => projectMembers.firstWhereOrNull((m) => m.userId == _authUser?.id);

  bool get _hpMemberUpdate => me?.hp('MEMBER_UPDATE') == true || ws.hpProjectContentUpdate;
  bool get _hpMemberRead => me?.hp('MEMBER_READ') == true || ws.hpProjectContentUpdate;
  bool get _hpCreate => me?.hp('TASK_CREATE') == true || ws.hpProjectContentUpdate;
  bool get _hpUpdate => me?.hp('TASK_UPDATE') == true || ws.hpProjectContentUpdate;
  bool get _hpDelete => me?.hp('TASK_DELETE') == true || ws.hpProjectContentUpdate;
  bool get _hpProjectInfoRead => me?.hp('PROJECT_INFO_READ') == true || ws.hpProjectContentUpdate;
  bool get _hpProjectInfoUpdate => me?.hp('PROJECT_INFO_UPDATE') == true || ws.hpProjectContentUpdate;

  /// доступные действия
  bool get _isLocal => !linked;
  bool get isLinkedProject => isProject && !_isLocal;

  bool get canCreate => _isLocal && !closed && _hpCreate;
  bool get canEdit => _isLocal && ((isProject && ws.hpProjectUpdate == true) || _hpUpdate);
  bool get canDelete => (isProject && ws.hpProjectDelete == true) || (_isLocal && _hpDelete);
  bool get canReopen => closed && canEdit && (isProject || parent?.closed == false);
  bool get canClose => canEdit && !closed;
  bool get canUnlink => isLinkedProject && ws.hpProjectUpdate == true;
  bool get canViewMembers => isProject && _hpMemberRead;
  bool get canEditMembers => isProject && _hpMemberUpdate;
  bool get canSetStatus => statuses.isNotEmpty && canEdit && isTask;
  bool get canCloseGroup => canClose && state == TaskState.CLOSABLE;
  bool get canEstimate => canEdit && ws.estimateValues.isNotEmpty && isTask;
  bool get canAssign => canEdit && activeMembers.isNotEmpty;
  bool get canLocalExport => canEdit && goalsForLocalExport.isNotEmpty;
  bool get canLocalImport => canEdit && goalsForLocalImport.isNotEmpty;
  bool get canComment => !isProject && canEdit;
  bool get canViewFeatureSets => isProject && _hpProjectInfoRead;
  bool get canEditFeatureSets => isProject && _hpProjectInfoUpdate;

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
