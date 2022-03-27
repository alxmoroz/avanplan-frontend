// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/api_schema/task.dart';
import '../../../L1_domain/entities/goals/goal.dart';
import '../../../L1_domain/entities/goals/task.dart';
import '../../../L1_domain/entities/goals/task_status.dart';
import '../../components/confirmation_dialog.dart';
import '../../components/text_field_annotation.dart';
import '../../extra/services.dart';
import '../smartable/smartable_controller.dart';

part 'task_edit_controller.g.dart';

class TaskEditController extends _TaskEditControllerBase with _$TaskEditController {}

// TODO: подумать над объединением с контроллером просмотра. Проблему может доставить initState, который вызывает вьюха редактирования
//  можно ли вообще несколько вьюх на один контроллер?

abstract class _TaskEditControllerBase extends SmartableController<TaskStatus> with Store {
  Goal get goal => mainController.selectedGoal!;

  @override
  void initState({List<TFAnnotation>? tfaList}) {
    super.initState(tfaList: tfaList);
    setDueDate(selectedTask?.dueDate);
    setClosed(selectedTask?.closed);
  }

  /// выбранная задача
  @observable
  Task? selectedTask;

  @action
  void selectTask(Task? _task) => selectedTask = _task;

  @computed
  bool get canEdit => selectedTask != null;

  @computed
  int? get _parentId => canEdit ? taskViewController.task?.parentId : taskViewController.task?.id;

  @override
  bool get allNeedFieldsTouched => super.allNeedFieldsTouched || (canEdit && anyFieldTouched);

  @action
  Future fetchStatuses() async {
    statuses = ObservableList.of(await taskStatusesUC.getStatuses());
    sortStatuses();
    selectStatus(selectedTask?.status);
  }

  /// дата

  Future saveTask(BuildContext context) async {
    final editedTask = await tasksUC.save(TaskUpsert(
      goalId: goal.id,
      id: selectedTask?.id,
      parentId: _parentId,
      title: tfAnnoForCode('title').text,
      description: tfAnnoForCode('description').text,
      closed: closed,
      dueDate: selectedDueDate,
      statusId: selectedStatusId,
    ));

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
        Navigator.of(context).pop(await tasksUC.delete(task: selectedTask!));
      }
    }
  }
}
