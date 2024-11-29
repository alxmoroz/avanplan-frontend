// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/user.dart';
import '../../L1_domain/entities/ws_member.dart';
import '../../L1_domain/entities_extensions/task_members.dart';
import '../../L1_domain/entities_extensions/task_params.dart';
import '../../L1_domain/entities_extensions/task_type.dart';
import '../../L1_domain/entities_extensions/ws_tariff.dart';
import '../components/adaptive.dart';
import '../extra/services.dart';
import '../usecases/ws_actions.dart';
import 'task_tree.dart';

enum TaskAction {
  details,

  assignee,
  finance,
  estimate,
  relations,

  close,
  reopen,
  localExport,
  localImport,
  duplicate,

  delete,
  divider;

  bool get isDivider => this == divider;
}

extension TaskActionsUC on Task {
  /// разрешения для текущего участника РП, выбранной задачи или проекта
  User? get _authUser => myAccountController.me;
  WSMember? get me => activeMembers.firstWhereOrNull((m) => m.userId == _authUser?.id);

  bool get _hpMemberUpdate => me?.hp('MEMBER_UPDATE') == true || ws.hpProjectContentUpdate;
  bool get _hpMemberRead => me?.hp('MEMBER_READ') == true || ws.hpProjectContentUpdate;
  bool get _hpCreate => me?.hp('TASK_CREATE') == true || ws.hpProjectContentUpdate;
  bool get _hpUpdate => me?.hp('TASK_UPDATE') == true || ws.hpProjectContentUpdate;
  bool get _hpDelete => me?.hp('TASK_DELETE') == true || ws.hpProjectContentUpdate;
  // bool get _hpProjectInfoRead => me?.hp('PROJECT_INFO_READ') == true || ws.hpProjectContentUpdate;
  bool get _hpProjectInfoUpdate => me?.hp('PROJECT_INFO_UPDATE') == true || ws.hpProjectContentUpdate;

  /// доступные действия

  bool get canCreate => !closed && isLocal && _hpCreate;
  bool get canCreateSubtask => !isTask && canCreate;
  bool get canCreateChecklist => isTask && canCreate;

  bool get canDuplicate => !isInbox && canCreate;
  bool get canEdit => !isInbox && isLocal && ((isProject && ws.hpProjectUpdate == true) || _hpUpdate);
  bool get _canEditTask => isTask && canEdit;
  bool get canDelete => !isInbox && ((isProject && ws.hpProjectDelete == true) || (isLocal && _hpDelete));
  bool get canReopen => closed && canEdit && (isProject || parent?.closed == false);
  bool get canClose => !closed && canEdit;
  // bool get canUnlink => isLinkedProject && ws.hpProjectUpdate == true;

  bool canShowDetails(BuildContext context) => !isBigScreen(context) && isProjectOrGoal;

  bool get canShowTeam => isProject && _hpMemberRead && ws.hfTeam;
  bool get canEditTeam => canShowTeam && _hpMemberUpdate;
  bool get canInviteMember => canEditTeam && ws.roles.isNotEmpty;

  bool get canShowStatus => hasStatus && project.projectStatuses.length > 2;
  bool get canSetStatus => project.projectStatuses.isNotEmpty && _canEditTask;

  bool get canShowEstimate => ws.hfAnalytics && isTask && hasEstimate;
  bool get canEstimate => ws.hfAnalytics && _canEditTask && ws.estimateValues.isNotEmpty;

  bool get canEditFinance => ws.hfFinance && _canEditTask;

  bool get canCloseGroup => canClose && state == TaskState.CLOSABLE;

  bool get canLocalExport => canEdit && !isProject && !isInbox;
  bool get canLocalImport => canEdit && (isGoal || isBacklog || isProjectWithoutGroups);

  bool get canComment => !closed && _canEditTask;

  bool get canEditProjectStatuses => _hpProjectInfoUpdate;

  bool get canShowBoard => hasSubtasks && (isGoal || isProjectWithoutGroups);
  bool get canShowAssigneeFilter => hasSubtasks && ws.hfTeam && activeMembers.isNotEmpty;
  bool get canEditViewSettings => canShowBoard || canShowAssigneeFilter;

  bool get canEditRelations => _canEditTask;
}
