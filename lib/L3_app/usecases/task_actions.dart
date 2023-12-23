// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/member.dart';
import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/user.dart';
import '../../L1_domain/entities_extensions/task_members.dart';
import '../../L1_domain/entities_extensions/task_stats.dart';
import '../../L1_domain/entities_extensions/task_tree.dart';
import '../components/adaptive.dart';
import '../extra/services.dart';
import 'task_feature_sets.dart';
import 'task_status.dart';
import 'task_transfer.dart';
import 'task_tree.dart';
import 'ws_actions.dart';

enum TaskActionType {
  details,
  close,
  reopen,
  localExport,
  duplicate,
  // go2source,
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

  bool get canCreate => !closed && isLocal && _hpCreate;
  bool get canEdit => isLocal && ((isProject && ws.hpProjectUpdate == true) || _hpUpdate);
  bool get canDelete => (isProject && ws.hpProjectDelete == true) || (isLocal && _hpDelete);
  bool get canReopen => closed && canEdit && (isProject || parent?.closed == false);
  bool get canClose => !closed && canEdit;
  bool get canUnlink => isLinkedProject && ws.hpProjectUpdate == true;

  bool get canShowDetails => !isBigScreen && isGroup;

  bool get canShowMembers => isProject && hfsTeam && _hpMemberRead;
  bool get canEditMembers => isProject && hfsTeam && _hpMemberUpdate;
  bool get canInviteMembers => canEditMembers && ws.roles.isNotEmpty;

  bool get canShowStatus => hfsTaskboard && hasStatus;
  bool get canSetStatus => isTask && hfsTaskboard && statuses.isNotEmpty && canEdit;

  bool get canAssign => canEdit && hfsTeam && activeMembers.isNotEmpty;
  bool get canShowAssignee => hfsTeam && (hasAssignee || canAssign);

  bool get canEstimate => isTask && !closed && hfsEstimates && canEdit && ws.estimateValues.isNotEmpty;

  bool get canCloseGroup => canClose && state == TaskState.CLOSABLE;

  bool get canLocalExport => canEdit && hfsGoals && goalsForLocalExport.isNotEmpty;
  bool get canLocalImport => !isTask && canEdit && hfsGoals && goalsForLocalImport.isNotEmpty;

  bool get canComment => isTask && canEdit;

  bool get canShowFeatureSets => isProject && _hpProjectInfoRead;
  bool get canEditFeatureSets => isProject && _hpProjectInfoUpdate;

  bool get canEditProjectStatuses => isProject && hfsTaskboard && _hpProjectInfoUpdate;

  bool get canAddChecklist => !closed && isTask && canEdit && subtasks.isEmpty;
  bool get canShowBoard => (isGoal || (isProject && !hfsGoals)) && hfsTaskboard && hasSubtasks;

  Iterable<TaskActionType> get actions => [
        if (canShowDetails) TaskActionType.details,
        if (canClose) TaskActionType.close,
        if (canReopen) TaskActionType.reopen,
        if (canLocalExport) TaskActionType.localExport,
        if (canCreate) TaskActionType.duplicate,
        // if (didImported) TaskActionType.go2source,
        if (canUnlink) TaskActionType.unlink,
        if (canDelete) TaskActionType.delete,
      ];
}
