// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import '../../../../L1_domain/entities/tariff_option.dart';
import '../../../../L1_domain/entities/ws_member.dart';
import '../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../L1_domain/entities_extensions/ws_tariff.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/select_dialog.dart';
import '../../../components/text.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_tree.dart';
import '../../../presenters/ws_member.dart';
import '../../workspace/ws_controller.dart';
import '../../workspace/ws_feature_dialog.dart';
import '../controllers/task_controller.dart';
import 'edit.dart';

extension AssigneeUC on TaskController {
  Future _reset() async {
    final t = task;
    final oldAssigneeId = t.assigneeId;
    t.assigneeId = null;
    await _assign(oldAssigneeId);
  }

  Future _assign(int? oldAssigneeId) async {
    if (!(await saveField(TaskFCode.assignee))) {
      task.assigneeId = oldAssigneeId;
    }
  }

  Future startAssign() async {
    final t = task;

    // проверка наличия функции
    final ws = t.ws;
    if (!ws.hfTeam) {
      final wsc = WSController(wsIn: ws);
      await wsFeature(wsc, toCode: TOCode.TEAM);
    }
    if (!ws.hfTeam) return;

    // TODO: проверка количества участников в проекте
    // Переход к добавлению участников
    // activeMembers.isNotEmpty

    // назначение
    final assignee = await showMTSelectDialog<WSMember>(
      t.activeMembers,
      t.assigneeId,
      loc.task_assignee_placeholder,
      parentPageTitle: t.title,
      leadingBuilder: (_, member) => member.icon(P3),
      valueBuilder: (_, member) => BaseText('$member', maxLines: 1),
      dividerIndent: P5 + DEF_TAPPABLE_ICON_SIZE,
      onReset: t.assigneeId != null ? _reset : null,
    );

    final oldAssigneeId = t.assigneeId;
    if (assignee != null && assignee.id != oldAssigneeId) {
      t.assigneeId = assignee.id;
      tasksMainController.refreshUI();
      await _assign(oldAssigneeId);
    }
  }
}
