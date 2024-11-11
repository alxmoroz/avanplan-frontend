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

  assignee,
  finance,
  estimate,
  relations,

  close,
  reopen,
  localExport,
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
  bool get _hpProjectInfoRead => me?.hp('PROJECT_INFO_READ') == true || ws.hpProjectContentUpdate;
  bool get _hpProjectInfoUpdate => me?.hp('PROJECT_INFO_UPDATE') == true || ws.hpProjectContentUpdate;

  /// доступные действия

  bool get canCreate => !closed && isLocal && _hpCreate;
  bool get canCreateSubtask => canCreate && !isTask;
  bool get canCreateChecklist => canCreate && isTask;

  bool get canDuplicate => !isInbox && canCreate;
  bool get canEdit => !isInbox && isLocal && ((isProject && ws.hpProjectUpdate == true) || _hpUpdate);
  bool get _canEditTask => isTask && canEdit;
  bool get canDelete => !isInbox && ((isProject && ws.hpProjectDelete == true) || (isLocal && _hpDelete));
  bool get canReopen => closed && canEdit && (isProject || parent?.closed == false);
  bool get canClose => !closed && canEdit;
  // bool get canUnlink => isLinkedProject && ws.hpProjectUpdate == true;

  bool canShowDetails(BuildContext context) => !isBigScreen(context) && isProjectOrGoal;

  bool get canShowMembers => isProject && hmTeam && _hpMemberRead;
  bool get canEditMembers => isProject && hmTeam && _hpMemberUpdate;
  bool get canInviteMembers => canEditMembers && ws.roles.isNotEmpty;

  bool get canShowStatus => hasStatus && project.projectStatuses.length > 2;
  bool get canSetStatus => project.projectStatuses.isNotEmpty && _canEditTask;

  bool get canAssign => hmTeam && canEdit && activeMembers.isNotEmpty;

  bool get canShowEstimate => hmAnalytics && isTask && hasEstimate;
  bool get canEstimate => hmAnalytics && _canEditTask && ws.estimateValues.isNotEmpty;

  bool get canEditFinance => hmFinance && _canEditTask;

  bool get canCloseGroup => canClose && state == TaskState.CLOSABLE;

  bool get canLocalExport => canEdit && !isProject && !isInbox;
  bool get canLocalImport => canEdit && (isGoal || isBacklog || (isProject && !hmGoals));

  bool get canComment => !closed && _canEditTask;

  bool get canShowProjectModules => isProject && _hpProjectInfoRead;
  bool get canEditProjectModules => isProject && _hpProjectInfoUpdate;

  bool get canEditProjectStatuses => _hpProjectInfoUpdate;

  bool get canShowBoard => isGoal || (isProject && !hmGoals);
  bool get canEditViewSettings => canShowBoard || (isGroup && hmTeam);

  bool get canEditRelations => _canEditTask;
}
