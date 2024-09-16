// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/user.dart';
import '../../L1_domain/entities/ws_member.dart';
import '../../L1_domain/entities_extensions/task_members.dart';
import '../../L1_domain/entities_extensions/task_params.dart';
import '../../L1_domain/entities_extensions/task_type.dart';
import '../components/adaptive.dart';
import '../extra/services.dart';
import '../usecases/ws_actions.dart';
import 'project_module.dart';
import 'task_tree.dart';

enum TaskAction {
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
  User? get _authUser => accountController.me;

  /// разрешения для текущего участника РП, выбранной задачи или проекта
  WSMember? get me => activeMembers.firstWhereOrNull((m) => m.userId == _authUser?.id);

  bool get _hpMemberUpdate => me?.hp('MEMBER_UPDATE') == true || ws.hpProjectContentUpdate;
  bool get _hpMemberRead => me?.hp('MEMBER_READ') == true || ws.hpProjectContentUpdate;
  bool get _hpCreate => me?.hp('TASK_CREATE') == true || ws.hpProjectContentUpdate;
  bool get _hpUpdate => me?.hp('TASK_UPDATE') == true || ws.hpProjectContentUpdate;
  bool get _hpDelete => me?.hp('TASK_DELETE') == true || ws.hpProjectContentUpdate;
  bool get _hpProjectInfoRead => me?.hp('PROJECT_INFO_READ') == true || ws.hpProjectContentUpdate;
  bool get _hpProjectInfoUpdate => me?.hp('PROJECT_INFO_UPDATE') == true || ws.hpProjectContentUpdate;

  /// доступные действия

  bool get canCreate => !closed && isLocal && _hpCreate;
  bool get canCreateSubtask => canCreate && !isTask;
  bool get canCreateChecklist => canCreate && isTask;

  bool get canDuplicate => !isInbox && canCreate;
  bool get canEdit => !isInbox && isLocal && ((isProject && ws.hpProjectUpdate == true) || _hpUpdate);
  bool get canDelete => !isInbox && ((isProject && ws.hpProjectDelete == true) || (isLocal && _hpDelete));
  bool get canReopen => closed && canEdit && (isProject || parent?.closed == false);
  bool get canClose => !closed && canEdit;
  bool get canUnlink => isLinkedProject && ws.hpProjectUpdate == true;

  bool canShowDetails(BuildContext context) => !isBigScreen(context) && isProjectOrGoal;

  bool get canShowMembers => isProject && hmTeam && _hpMemberRead;
  bool get canEditMembers => isProject && hmTeam && _hpMemberUpdate;
  bool get canInviteMembers => canEditMembers && ws.roles.isNotEmpty;

  bool get canShowStatus => hmTaskboard && hasStatus;
  bool get canSetStatus => isTask && hmTaskboard && project.projectStatuses.isNotEmpty && canEdit;

  bool get canAssign => canEdit && hmTeam && activeMembers.isNotEmpty;
  bool get canShowAssignee => hmTeam && (hasAssignee || canAssign);

  bool get canShowEstimate => hmAnalytics && isTask && hasEstimate;
  bool get canEstimate => hmAnalytics && isTask && canEdit && ws.estimateValues.isNotEmpty;

  bool get canShowFinanceField => hmFinance && isTask;

  bool get canCloseGroup => canClose && state == TaskState.CLOSABLE;

  bool get canLocalExport => canEdit && !isProject && !isInbox;
  bool get canLocalImport => canEdit && (isGoal || isBacklog || (isProject && !hmGoals));

  bool get canComment => isTask && !closed && canEdit;

  bool get canShowProjectModules => isProject && _hpProjectInfoRead;
  bool get canEditProjectModules => isProject && _hpProjectInfoUpdate;

  bool get canEditProjectStatuses => hmTaskboard && _hpProjectInfoUpdate;

  bool get canShowBoard => (isGoal || (isProject && !hmGoals)) && hmTaskboard;

  Iterable<TaskAction> actions(BuildContext context) => [
        if (canShowDetails(context)) TaskAction.details,
        if (canClose) TaskAction.close,
        if (canReopen) TaskAction.reopen,
        if (canLocalExport) TaskAction.localExport,
        if (canDuplicate) TaskAction.duplicate,
        // if (didImported) TaskAction.go2source,
        if (canUnlink) TaskAction.unlink,
        if (canDelete) TaskAction.delete,
      ];

  Iterable<TaskAction> get quickActions => [
        if (isInboxTask && canLocalExport) TaskAction.localExport,
      ];

  Iterable<TaskAction> get otherActions => [
        if (!isTask && canClose) TaskAction.close,
        if (!isTask && canReopen) TaskAction.reopen,
        if (!isInboxTask && canLocalExport) TaskAction.localExport,
        if (canDuplicate) TaskAction.duplicate,
        if (canUnlink) TaskAction.unlink,
        if (canDelete) TaskAction.delete,
      ];
}
