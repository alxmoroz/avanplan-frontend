// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/api_schema/task.dart';
import '../../../L1_domain/entities/goals/goal.dart';
import '../../../L1_domain/entities/goals/task.dart';
import '../../../L1_domain/entities/goals/task_status.dart';
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
    setDueDate(selectedTask?.dueDate);
    super.initState(tfaList: tfaList);
  }

  /// выбранная задача
  @observable
  Task? selectedTask;

  @action
  void selectTask(Task? _task) => selectedTask = _task;

  @computed
  int? get _parentId => canEdit ? taskViewController.task?.parentId : taskViewController.task?.id;

  @override
  bool get allNeedFieldsTouched => super.allNeedFieldsTouched || (canEdit && anyFieldTouched);

  /// статус
  @observable
  ObservableList<TaskStatus> statuses = ObservableList();

  @action
  void _sortStatuses() {
    statuses.sort((s1, s2) => s1.title.compareTo(s2.title));
  }

  @action
  Future fetchGoalStatuses() async {
    statuses = ObservableList.of(await taskStatusesUC.getStatuses());
    _sortStatuses();
    selectStatus(selectedTask?.status);
  }

  @observable
  int? selectedStatusId;

  @action
  void selectStatus(TaskStatus? _status) {
    selectedStatusId = _status?.id;
  }

  @computed
  TaskStatus? get selectedStatus => statuses.firstWhereOrNull((s) => s.id == selectedStatusId);

  /// дата

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
    final editedTask = await tasksUC.save(TaskUpsert(
      goalId: goal.id,
      id: selectedTask?.id,
      parentId: _parentId,
      title: tfAnnoForCode('title').text,
      description: tfAnnoForCode('description').text,
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
