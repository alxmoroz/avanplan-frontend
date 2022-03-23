// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/goals/goal.dart';
import '../../../L1_domain/entities/goals/task.dart';
import '../../components/confirmation_dialog.dart';
import '../../components/text_field_annotation.dart';
import '../../extra/services.dart';
import '../../presenters/date_presenter.dart';
import '../_base/base_controller.dart';

part 'task_edit_controller.g.dart';

class TaskEditController extends _TaskEditControllerBase with _$TaskEditController {}

// TODO: подумать над объединением с контроллером просмотра. Проблему может доставить initState, который вызывает вьюха редактирования
//  можно ли вообще несколько вьюх на один контроллер?

abstract class _TaskEditControllerBase extends BaseController with Store {
  Goal get goal => mainController.selectedGoal!;

  @override
  void initState({List<TFAnnotation>? tfaList}) {
    super.initState(tfaList: tfaList);
    setDueDate(selectedTask?.dueDate);
  }

  @observable
  Task? selectedTask;

  @action
  void selectTask(Task? _task) => selectedTask = _task;

  @computed
  int? get _parentId => canEdit ? taskViewController.selectedTask?.parentId : taskViewController.selectedTask?.id;

  @override
  bool get allNeedFieldsTouched => super.allNeedFieldsTouched || (canEdit && anyFieldTouched);

  @observable
  DateTime? selectedDueDate;

  @action
  void setDueDate(DateTime? _date) {
    selectedDueDate = _date;
    controllers['dueDate']?.text = _date != null ? _date.strLong : '';
  }

  @computed
  bool get canEdit => selectedTask != null;

  Future saveTask(BuildContext context) async {
    final editedTask = await tasksUC.saveTask(
      goal: goal,
      id: selectedTask?.id,
      parentId: _parentId,
      title: tfAnnoForCode('title').text,
      description: tfAnnoForCode('description').text,
      dueDate: selectedDueDate,
    );

    if (editedTask != null) {
      Navigator.of(context).pop(editedTask);
    }
  }

  Future deleteTask(BuildContext context) async {
    if (canEdit) {
      final confirm = await showMTDialog<bool?>(
        context,
        title: loc.task_delete_dialog_title,
        description: '${loc.task_delete_dialog_description}\n${loc.common_delete_dialog_description}',
        actions: [
          MTDialogAction(title: loc.common_yes, isDestructive: true, result: true),
          MTDialogAction(title: loc.common_no, isDefault: true, result: false),
        ],
      );
      if (confirm != null && confirm) {
        Navigator.of(context).pop(await tasksUC.deleteTask(task: selectedTask!, goal: goal));
      }
    }
  }
}
