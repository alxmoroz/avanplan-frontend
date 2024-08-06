// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/project_module.dart';
import '../../../../presenters/source.dart';
import '../../../../presenters/task_type.dart';
import '../../../../usecases/task_actions.dart';
import '../../../../usecases/task_source.dart';
import '../../../../usecases/task_tree.dart';
import '../../controllers/task_controller.dart';
import '../attachments/attachments_field.dart';
import '../finance/finance_field.dart';
import '../notes/notes.dart';
import '../project_modules/project_modules.dart';
import '../tasks/task_checklist.dart';
import 'assignee_field.dart';
import 'due_date_field.dart';
import 'estimate_field.dart';
import 'start_date_field.dart';
import 'task_description_field.dart';
import 'task_status_field.dart';

Future showDetailsDialog(TaskController controller) async => await showMTDialog<void>(
      MTDialog(
        topBar: MTAppBar(showCloseButton: true, color: b2Color, middle: controller.task.subPageTitle(loc.details)),
        body: TaskDetails(controller, standalone: true),
      ),
    );

class TaskDetails extends StatelessWidget {
  const TaskDetails(this._controller, {super.key, this.standalone = false, this.compact = false});
  final TaskController _controller;
  final bool standalone;
  final bool compact;

  Task get _task => _controller.task;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final t = _task;
      final isTaskDialog = isBigScreen(context) && t.isTask;
      final isTaskMobileView = !isBigScreen(context) && t.isTask;
      final showDescription = !isTaskDialog && (t.hasDescription || t.canEdit);
      final hasMargins = standalone || isTaskMobileView;

      return ListView(
        shrinkWrap: true,
        physics: standalone ? null : const NeverScrollableScrollPhysics(),
        children: [
          /// Описание
          if (showDescription) ...[if (hasMargins) const SizedBox(height: P), TaskDescriptionField(_controller)],

          /// Чек-лист
          if (!isTaskDialog && (t.canCreateChecklist || t.isCheckList)) ...[
            const SizedBox(height: P3),
            TaskChecklist(_controller),
          ],

          /// Статус
          if (t.canShowStatus) TaskStatusField(_controller, compact: compact, hasMargin: hasMargins),

          /// Назначенный
          if (t.canShowAssignee) TaskAssigneeField(_controller, compact: compact, hasMargin: hasMargins),

          /// Даты
          if (!t.isInbox) TaskStartDateField(_controller, compact: compact, hasMargin: hasMargins),
          if (t.hasDueDate || t.canEdit) TaskDueDateField(_controller, compact: compact, hasMargin: hasMargins),

          /// Оценки
          if (t.canShowEstimate || t.canEstimate) TaskEstimateField(_controller, compact: compact, hasMargin: hasMargins),

          /// Финансы
          if (t.canShowFinanceField && !isTaskDialog) FinanceField(_controller, hasMargin: hasMargins),

          /// Вложения
          if (!isTaskDialog && t.attachments.isNotEmpty) TaskAttachmentsField(_controller, hasMargin: hasMargins),

          /// Модули проекта
          if (t.canShowProjectModules)
            MTField(
              _controller.fData(TaskFCode.projectModules.index),
              margin: EdgeInsets.only(top: hasMargins ? P3 : 0),
              leading: SettingsIcon(color: t.canEditProjectModules ? mainColor : f3Color),
              value: BaseText(t.localizedModules, maxLines: 1),
              compact: compact,
              onTap: t.canEditProjectModules ? () => projectModulesDialog(_controller) : null,
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
          if (isTaskMobileView && _controller.notesController.hasNotes) Notes(_controller),
        ],
      );
    });
  }
}
