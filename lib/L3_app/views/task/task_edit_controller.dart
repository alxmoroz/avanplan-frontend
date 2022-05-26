// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/api_schema/task_upsert.dart';
import '../../../L1_domain/entities/goals/element_of_work.dart';
import '../../../L1_domain/entities/goals/goal.dart';
import '../../../L1_domain/entities/goals/task.dart';
import '../../../L1_domain/entities/goals/task_status.dart';
import '../../components/mt_confirm_dialog.dart';
import '../../components/mt_dropdown.dart';
import '../../components/text_field_annotation.dart';
import '../../extra/services.dart';
import '../element_of_work/ew_edit_controller.dart';

part 'task_edit_controller.g.dart';

class TaskEditController extends _TaskEditControllerBase with _$TaskEditController {}

// TODO: подумать над объединением с контроллером просмотра. Проблему может доставить initState, который вызывает вьюха редактирования
//  можно ли вообще несколько вьюх на один контроллер?

abstract class _TaskEditControllerBase extends EWEditController with Store {
  Goal get _goal => goalController.selectedGoal!;

  @override
  void initState({List<TFAnnotation>? tfaList}) {
    super.initState(tfaList: tfaList);
    setDueDate(selectedEW?.dueDate);
    setClosed(selectedEW?.closed);
    if (!ewViewController.isGoal) {
      selectStatus((selectedEW as Task?)?.status);
    }
  }

  @override
  void setClosed(bool? _closed) {
    super.setClosed(_closed);
    if (!closed && selectedStatus != null && selectedStatus!.closed) {
      selectedStatusId = null;
    }
  }

  /// статусы задач

  @computed
  List<TaskStatus> get taskStatuses {
    final ws = mainController.workspaces.firstWhereOrNull((ws) => ws.id == _goal.workspaceId);

    return ws != null ? ws.taskStatuses : [];
  }

  @observable
  int? selectedStatusId;

  @action
  void selectStatus(TaskStatus? _status) {
    selectedStatusId = _status?.id;
    if (_status != null && _status.closed) {
      closed = true;
    }
  }

  @computed
  TaskStatus? get selectedStatus => taskStatuses.firstWhereOrNull((s) => s.id == selectedStatusId);

  List<Widget> customFields(BuildContext context) {
    final items = <Widget>[];
    if (taskStatuses.isNotEmpty) {
      items.add(MTDropdown<TaskStatus>(
        onChanged: (status) => selectStatus(status),
        value: selectedStatus,
        items: taskStatuses,
        label: loc.common_status_placeholder,
      ));
    }
    return items;
  }

  /// выбранная задача
  @observable
  ElementOfWork? selectedEW;

  @action
  void selectTask(ElementOfWork? _ew) => selectedEW = _ew;

  @override
  @computed
  bool get canEdit => selectedEW != null;

  @computed
  int? get _parentId => canEdit ? ewViewController.selectedTask?.parentId : ewViewController.selectedTask?.id;

  /// действия

  Future save(BuildContext context) async {
    final editedTask = await tasksUC.save(TaskUpsert(
      goalId: _goal.id,
      id: selectedEW?.id,
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

  @override
  Future delete(BuildContext context) async {
    if (canEdit) {
      final confirm = await showMTDialog<bool?>(
        context,
        title: loc.task_delete_dialog_title,
        description: '${loc.ew_delete_dialog_description}\n${loc.common_delete_dialog_description}',
        actions: [
          MTDialogAction(title: loc.common_yes, isDestructive: true, result: true),
          MTDialogAction(title: loc.common_no, isDefault: true, result: false),
        ],
      );
      if (confirm != null && confirm) {
        final deletedEW = ewViewController.isGoal ? await goalsUC.delete(goal: selectedEW as Goal) : await tasksUC.delete(task: selectedEW as Task);
        Navigator.of(context).pop(deletedEW);
      }
    }
  }
}
