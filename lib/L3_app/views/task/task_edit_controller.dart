// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/entities_extensions/task_level.dart';
import '../../../main.dart';
import '../../components/mt_alert_dialog.dart';
import '../../components/mt_field_data.dart';
import '../../extra/services.dart';
import '../../presenters/task_level_presenter.dart';
import '../../views/_base/edit_controller.dart';
import 'task_edit_view.dart';
import 'task_view_controller.dart';

part 'task_edit_controller.g.dart';

class TaskEditController extends _TaskEditControllerBase with _$TaskEditController {
  TaskEditController(int _wsId, {required Task parent, Task? task}) {
    wsId = _wsId;
    this.parent = parent;
    this.task = task;
    isNew = task == null;

    initState(fds: [
      MTFieldData(TaskFCode.title.index, label: loc.title, text: task?.title ?? ''),
    ]);
  }
}

abstract class _TaskEditControllerBase extends EditController with Store {
  late final int wsId;
  late final Task parent;
  late final Task? task;
  late final bool isNew;

  /// действия

  String get saveAndGoBtnTitle => (parent.isProject || parent.isRoot) ? loc.save_and_go_action_title : loc.save_and_repeat_action_title;

  Future<Task?> _saveTask() async => await taskUC.save(
        Task(
          id: task?.id,
          parent: parent,
          title: fData(TaskFCode.title.index).text,
          description: task?.description ?? '',
          closed: task?.closed == true,
          statusId: isNew ? ws.statuses.firstOrNull?.id : task!.statusId,
          estimate: task?.estimate,
          startDate: task?.startDate,
          dueDate: task?.dueDate,
          tasks: task?.tasks ?? [],
          type: task?.type,
          assigneeId: task?.assigneeId,
          authorId: task?.authorId,
          members: task?.members ?? [],
          wsId: wsId,
        ),
      );

  Future save({bool proceed = false}) async {
    loader.start();
    loader.setSaving();
    final editedTask = await _saveTask();
    if (editedTask != null) {
      Navigator.of(rootKey.currentContext!).pop(EditTaskResult(editedTask, proceed));
    }
    await loader.stop(300);
  }

  Future delete() async {
    final confirm = await showMTAlertDialog(
      rootKey.currentContext!,
      title: task!.deleteDialogTitle,
      description: '${loc.task_delete_dialog_description}\n${loc.delete_dialog_description}',
      actions: [
        MTADialogAction(title: loc.yes, type: MTActionType.isDanger, result: true),
        MTADialogAction(title: loc.no, type: MTActionType.isDefault, result: false),
      ],
      simple: true,
    );
    if (confirm == true) {
      loader.start();
      loader.setDeleting();
      final deletedTask = await taskUC.delete(task!);
      Navigator.of(rootKey.currentContext!).pop(EditTaskResult(deletedTask));
      await loader.stop(300);
    }
  }

  Workspace get ws => mainController.wsForId(wsId);
}
