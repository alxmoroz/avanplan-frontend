// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';

import '../../L1_domain/entities/member.dart';
import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/user.dart';
import '../../L1_domain/entities_extensions/task_members.dart';
import '../../L1_domain/entities_extensions/task_stats.dart';
import '../../L1_domain/entities_extensions/task_tree.dart';
import '../components/adaptive.dart';
import '../extra/services.dart';
import 'task_feature_sets.dart';
import 'task_tree.dart';
import 'ws_actions.dart';

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
  TaskMember? get me => projectMembers.firstWhereOrNull((m) => m.userId == _authUser?.id);

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

  bool get canShowMembers => isProject && hfTeam && _hpMemberRead;
  bool get canEditMembers => isProject && hfTeam && _hpMemberUpdate;
  bool get canInviteMembers => canEditMembers && ws.roles.isNotEmpty;

  bool get canShowStatus => hfTaskboard && hasStatus;
  bool get canSetStatus => isTask && hfTaskboard && project.projectStatuses.isNotEmpty && canEdit;

  bool get canAssign => canEdit && hfTeam && activeMembers.isNotEmpty;
  bool get canShowAssignee => hfTeam && (hasAssignee || canAssign);

  bool get canEstimate => isTask && !closed && canEdit && ws.estimateValues.isNotEmpty;

  bool get canCloseGroup => canClose && state == TaskState.CLOSABLE;

  bool get canLocalExport => canEdit && !isProject && !isInbox;
  bool get canLocalImport => canEdit && (isGoal || isBacklog || (isProject && !hfGoals));

  bool get canComment => isTask && !closed && canEdit;

  bool get canShowFeatureSets => isProject && _hpProjectInfoRead;
  bool get canEditFeatureSets => isProject && _hpProjectInfoUpdate;

  bool get canEditProjectStatuses => hfTaskboard && _hpProjectInfoUpdate;

  bool get canShowBoard => (isGoal || (isProject && !hfGoals)) && hfTaskboard;

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
        if (isTask && canClose) TaskAction.close,
        if (isTask && canReopen) TaskAction.reopen,
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
