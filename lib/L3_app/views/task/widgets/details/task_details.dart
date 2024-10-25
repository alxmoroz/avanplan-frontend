// Copyright (c) 2024. Alexandr Moroz

import 'package:avanplan/L3_app/views/task/widgets/relations/relations_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../L1_domain/entities_extensions/task_params.dart';
import '../../../../../L1_domain/entities_extensions/task_type.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/project_module.dart';
import '../../../../presenters/remote_source.dart';
import '../../../../presenters/task_actions.dart';
import '../../../../presenters/task_source.dart';
import '../../../../presenters/task_tree.dart';
import '../../controllers/task_controller.dart';
import '../attachments/attachments_field.dart';
import '../dates/dates_field.dart';
import '../finance/finance_field.dart';
import '../notes/notes.dart';
import '../project_modules/project_modules.dart';
import '../tasks/checklist.dart';
import 'assignee_field.dart';
import 'estimate_field.dart';
import 'task_status_field.dart';

Future showDetailsDialog(TaskController controller) async => await showMTDialog(
      MTDialog(
        topBar: MTTopBar(pageTitle: loc.details, parentPageTitle: controller.task.title),
        body: TaskDetails(controller, standalone: true),
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

          /// Назначенный
          if (_tc.canShowAssigneeField) TaskAssigneeField(_tc, compact: compact, hasMargin: hasMargins),

          /// Даты
          if (_tc.canShowDateField) TaskDatesField(_tc, compact: compact, hasMargin: hasMargins),

          /// Оценки
          if (_tc.canShowEstimateField) TaskEstimateField(_tc, compact: compact, hasMargin: hasMargins),

          if (!isTaskDialog) ...[
            /// Вложения
            if (_tc.canShowAttachmentsField) TaskAttachmentsField(_tc, hasMargin: hasMargins),

            /// Финансы
            if (_tc.canShowFinanceField) FinanceField(_tc, hasMargin: hasMargins),

            /// Связи
            if (_tc.canShowRelationsField) TaskRelationsField(_tc, hasMargin: hasMargins),
          ],

          /// Модули проекта
          if (t.canShowProjectModules)
            MTField(
              _tc.fData(TaskFCode.projectModules.index),
              margin: EdgeInsets.only(top: hasMargins ? P3 : 0),
              leading: SettingsIcon(color: t.canEditProjectModules ? mainColor : f3Color),
              value: BaseText(t.localizedModules, maxLines: 1),
              compact: compact,
              onTap: t.canEditProjectModules ? () => projectModulesDialog(_tc) : null,
            ),

          /// Связь с источником импорта
          if (t.didImported)
            MTListTile(
              margin: EdgeInsets.only(top: hasMargins ? P3 : 0),
              leading: t.source?.type.icon(size: P6),
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
