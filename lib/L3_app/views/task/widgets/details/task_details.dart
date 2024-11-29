// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../L1_domain/entities_extensions/task_params.dart';
import '../../../../../L1_domain/entities_extensions/task_type.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/remote_source.dart';
import '../../../../presenters/task_actions.dart';
import '../../../../presenters/task_source.dart';
import '../../../../presenters/task_tree.dart';
import '../../controllers/task_controller.dart';
import '../attachments/attachments_field.dart';
import '../dates/dates_field.dart';
import '../finance/finance_field.dart';
import '../notes/notes.dart';
import '../relations/relations_field.dart';
import '../tasks/checklist.dart';
import 'assignee_field.dart';
import 'estimate_field.dart';
import 'task_status_field.dart';

Future showDetailsDialog(TaskController tc) async => await showMTDialog(
      MTDialog(
        topBar: MTTopBar(pageTitle: loc.details, parentPageTitle: tc.task.title),
        body: TaskDetails(tc, standalone: true),
      ),
    );

class TaskDetails extends StatelessWidget {
  const TaskDetails(this._tc, {super.key, this.standalone = false, this.compact = false});
  final TaskController _tc;
  final bool standalone;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final t = _tc.task;
      final isTaskDialog = isBigScreen(context) && t.isTask;
      final isTaskMobileView = !isBigScreen(context) && t.isTask;
      final hasMargins = standalone || isTaskMobileView;

      return ListView(
        shrinkWrap: true,
        physics: standalone ? null : const NeverScrollableScrollPhysics(),
        children: [
          /// Чек-лист
          if (!isTaskDialog && (_tc.canCreateChecklist || t.isCheckList)) ...[
            const SizedBox(height: P3),
            TaskChecklist(_tc),
          ],

          /// Статус
          if (t.canShowStatus) TaskStatusField(_tc, compact: compact, hasMargin: hasMargins),

          /// Ответственный
          if (t.canShowAssignee) TaskAssigneeField(_tc, compact: compact, hasMargin: hasMargins),

          /// Даты
          if (_tc.canShowDateField) TaskDatesField(_tc, compact: compact, hasMargin: hasMargins),

          /// Оценки
          if (t.canShowEstimate) TaskEstimateField(_tc, compact: compact, hasMargin: hasMargins),

          if (!isTaskDialog) ...[
            /// Вложения
            if (_tc.canShowAttachmentsField) TaskAttachmentsField(_tc, hasMargin: hasMargins),

            /// Финансы
            if (t.canShowFinance) FinanceField(_tc, hasMargin: hasMargins),

            /// Связи
            if (_tc.relationsController.hasRelations) TaskRelationsField(_tc, hasMargin: hasMargins),
          ],

          /// Связь с источником импорта
          if (t.didImported)
            MTListTile(
              margin: EdgeInsets.only(top: hasMargins ? P3 : 0),
              leading: t.source?.type.icon(size: DEF_TAPPABLE_ICON_SIZE),
              titleText: !compact ? loc.task_go2source_title : null,
              trailing: !compact ? const LinkOutIcon() : null,
              bottomDivider: false,
              onTap: () => launchUrlString(t.taskSource!.urlString),
            ),

          /// Комментарии
          if (isTaskMobileView && _tc.notesController.hasNotes) Notes(_tc),
        ],
      );
    });
  }
}
