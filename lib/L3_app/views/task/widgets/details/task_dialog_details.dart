// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/field_data.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../usecases/task_actions.dart';
import '../../../../usecases/task_tree.dart';
import '../../controllers/task_controller.dart';
import '../attachments/attachments.dart';
import '../notes/notes.dart';
import '../tasks/task_checklist.dart';
import 'description_field.dart';
import 'task_status_field.dart';

class TaskDialogDetails extends StatelessWidget {
  const TaskDialogDetails(this._controller);
  final TaskController _controller;

  Task get _task => _controller.task!;
  bool get _showStatusRow => _task.canShowStatus || _task.canClose || _task.closed;
  bool get _showDescription => _task.hasDescription || _task.canEdit;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          /// Статус
          if (_showStatusRow) TaskStatusField(_controller),

          /// Описание
          if (_showDescription) ...[
            const SizedBox(height: P3),
            TaskDescriptionField(_controller),
          ],

          /// Кнопка для добавления чек-листа
          if (_task.canAddChecklist)
            MTField(
              MTFieldData(-1, placeholder: '${loc.action_add_title} ${loc.checklist.toLowerCase()}'),
              margin: const EdgeInsets.only(top: P3),
              leading: const PlusCircleIcon(color: mainColor),
              crossAxisAlignment: CrossAxisAlignment.center,
              onTap: () async => await _controller.subtasksController.addTask(),
            ),

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
              onTap: () => showAttachmentsDialog(_controller.attachmentsController),
            ),

          if (_controller.notesController.sortedNotesDates.isNotEmpty) Notes(_controller.notesController),
        ],
      ),
    );
  }
}
