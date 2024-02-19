// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../../L2_data/services/platform.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../../../usecases/task_actions.dart';
import '../../../../usecases/task_tree.dart';
import '../../controllers/task_controller.dart';
import '../attachments/attachment_list_dialog.dart';
import '../notes/notes.dart';
import '../tasks/task_checklist.dart';
import 'checklist_add_field.dart';
import 'description_field.dart';
import 'task_status_field.dart';

class TaskDialogDetails extends StatelessWidget {
  const TaskDialogDetails(this._controller, {super.key});
  final TaskController _controller;

  Task get _task => _controller.task!;
  bool get _showStatusRow => _task.canShowStatus || _task.closed;
  bool get _showDescription => _task.hasDescription || _task.canEdit;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          /// Статус
          if (_showStatusRow) ...[
            SizedBox(height: isWeb ? P2 : P),
            TaskStatusField(_controller),
          ],

          /// Описание
          if (_showDescription) TaskDescriptionField(_controller, hasMargin: true),

          /// Кнопка для добавления чек-листа
          if (_task.canAddChecklist) TaskChecklistAddField(_controller),

          /// Чек-лист
          if (_task.isCheckList) ...[
            const SizedBox(height: P3),
            TaskChecklist(_controller),
          ],

          /// Вложения
          if (_task.attachments.isNotEmpty)
            MTField(
              _controller.fData(TaskFCode.attachment.index),
              margin: const EdgeInsets.only(top: P3),
              leading: const AttachmentIcon(),
              value: Row(children: [
                Flexible(child: BaseText(_controller.attachmentsController.attachmentsStr, maxLines: 1)),
                if (_controller.attachmentsController.attachmentsCountMoreStr.isNotEmpty)
                  BaseText.f2(
                    _controller.attachmentsController.attachmentsCountMoreStr,
                    maxLines: 1,
                    padding: const EdgeInsets.only(left: P),
                  )
              ]),
              onTap: () => attachmentsDialog(_controller.attachmentsController),
            ),

          if (_controller.notesController.sortedNotesDates.isNotEmpty) Notes(_controller.notesController),
        ],
      ),
    );
  }
}
