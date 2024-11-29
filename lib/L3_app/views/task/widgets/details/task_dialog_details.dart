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
import '../relations/relations_field.dart';
import '../tasks/checklist.dart';

class TaskDialogDetails extends StatelessWidget {
  const TaskDialogDetails(this._tc, {super.key});
  final TaskController _tc;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final t = _tc.task;
      return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          /// Чек-лист
          if (_tc.canCreateChecklist || t.isCheckList) ...[
            const SizedBox(height: P3),
            TaskChecklist(_tc),
          ],

          /// Вложения
          if (_tc.canShowAttachmentsField) TaskAttachmentsField(_tc, hasMargin: true),

          /// Финансы
          if (t.canShowFinance) FinanceField(_tc, hasMargin: true),

          /// Связи
          if (_tc.relationsController.hasRelations) TaskRelationsField(_tc, hasMargin: true),

          /// Комментарии
          if (_tc.notesController.sortedNotesDates.isNotEmpty) Notes(_tc),
        ],
      );
    });
  }
}
