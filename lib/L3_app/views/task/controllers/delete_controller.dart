// Copyright (c) 2023. Alexandr Moroz

import 'dart:async';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../components/mt_alert_dialog.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_type.dart';
import '../../../usecases/task_edit.dart';

class DeleteController {
  Future delete(Task task) async {
    final confirm = await showMTAlertDialog(
      task.deleteDialogTitle,
      description: '${task.isTask ? '' : '${loc.task_delete_dialog_description}\n'}${loc.delete_dialog_description}',
      actions: [
        MTADialogAction(title: loc.yes, type: MTActionType.isDanger, result: true),
        MTADialogAction(title: loc.no, type: MTActionType.isDefault, result: false),
      ],
      simple: true,
    );
    if (confirm == true) {
      await task.delete();
    }
  }
}
