// Copyright (c) 2023. Alexandr Moroz

import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../../main.dart';
import '../../../components/alert_dialog.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_type.dart';
import '../../../usecases/task_edit.dart';
import 'task_controller.dart';

class DeleteController {
  DeleteController(this._taskController);
  final TaskController _taskController;
  Task? get _task => _taskController.task;

  Future delete() async {
    if (_task != null) {
      final confirm = await showMTAlertDialog(
        _task!.deleteDialogTitle,
        description: '${_task!.isTask ? '' : '${loc.task_delete_dialog_description}\n'}${loc.delete_dialog_description}',
        actions: [
          MTADialogAction(title: loc.yes, type: MTActionType.isDanger, result: true),
          MTADialogAction(title: loc.no, type: MTActionType.isDefault, result: false),
        ],
        simple: true,
      );
      if (confirm == true) {
        _task!.delete();
        Navigator.of(rootKey.currentContext!).pop();
      }
    }
  }
}
