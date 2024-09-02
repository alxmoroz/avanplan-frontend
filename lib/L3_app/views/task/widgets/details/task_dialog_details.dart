// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../components/constants.dart';
import '../../../../presenters/task_actions.dart';
import '../../../../presenters/task_tree.dart';
import '../../controllers/task_controller.dart';
import '../attachments/attachments_field.dart';
import '../finance/finance_field.dart';
import '../notes/notes.dart';
import '../tasks/task_checklist.dart';

class TaskDialogDetails extends StatelessWidget {
  const TaskDialogDetails(this._controller, {super.key});
  final TaskController _controller;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final t = _controller.task;
      return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          /// Чек-лист
          if (t.canCreateChecklist || t.isCheckList) ...[
            const SizedBox(height: P3),
            TaskChecklist(_controller),
          ],

          /// Финансы
          if (t.canShowFinanceField) FinanceField(_controller, hasMargin: true),

          /// Вложения
          if (t.attachments.isNotEmpty) TaskAttachmentsField(_controller, hasMargin: true),

          if (_controller.notesController.sortedNotesDates.isNotEmpty) Notes(_controller),
        ],
      );
    });
  }
}
