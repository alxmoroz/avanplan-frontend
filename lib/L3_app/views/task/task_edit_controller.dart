// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/estimate_value.dart';
import '../../../L1_domain/entities/member.dart';
import '../../../L1_domain/entities/status.dart';
import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/entities_extensions/task_level.dart';
import '../../../L1_domain/entities_extensions/task_members.dart';
import '../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../main.dart';
import '../../components/mt_dialog.dart';
import '../../components/text_field_annotation.dart';
import '../../extra/services.dart';
import '../../presenters/date_presenter.dart';
import '../../presenters/task_level_presenter.dart';
import '../../views/_base/edit_controller.dart';
import 'task_edit_view.dart';

part 'task_edit_controller.g.dart';

const _year = Duration(days: 365);

class TaskEditController extends _TaskEditControllerBase with _$TaskEditController {
  TaskEditController(int _wsId, Task _parent, Task? _task) {
    wsId = _wsId;
    parent = _parent;
    task = _task;
    isNew = task == null;

    initState(tfaList: [
      TFAnnotation('title', label: loc.title, text: task?.title ?? ''),
      TFAnnotation('description', label: loc.description, text: task?.description ?? '', needValidate: false),
      TFAnnotation('startDate', label: loc.task_start_date_placeholder, noText: true, needValidate: false),
      TFAnnotation('dueDate', label: loc.task_due_date_placeholder, noText: true, needValidate: false),
    ]);

    setStartDate(task?.startDate);
    setDueDate(task?.dueDate);
    selectEstimateByValue(task?.estimate);

    if (!isNew) {
      final imAlone = task?.activeMembers.length == 1 && task!.activeMembers[0].userId == accountController.user?.id;
      if (!imAlone) {
        setAllowedAssignees([
          Member(fullName: loc.task_assignee_nobody, id: null, email: '', isActive: false, roles: [], permissions: [], userId: null, taskId: -1),
          ...task?.activeMembers ?? [],
        ]);
      }
    }

    selectAssigneeId(task?.assigneeId);
    if (canSetStatus) {
      selectStatusId(task?.statusId ?? ws.statuses.firstOrNull?.id);
    }
  }
}

abstract class _TaskEditControllerBase extends EditController with Store {
  late final int wsId;
  late final Task parent;
  late final Task? task;
  late final bool isNew;

  @observable
  DateTime? selectedDueDate;

  @observable
  DateTime? selectedStartDate;

  @action
  void setStartDate(DateTime? _date) {
    selectedStartDate = _date;
    teControllers['startDate']?.text = _date != null ? _date.strLong : '';
  }

  @action
  void setDueDate(DateTime? _date) {
    selectedDueDate = _date;
    teControllers['dueDate']?.text = _date != null ? _date.strLong : '';
  }

  Future selectDate(String code) async {
    final isStart = code == 'startDate';

    final today = DateTime.now();
    final pastDate = today.subtract(_year);
    final lastDate = (isStart ? selectedDueDate?.subtract(const Duration(days: 1)) : null) ?? today.add(_year * 100);
    final initialDate = (isStart ? selectedStartDate : selectedDueDate) ?? (today.isAfter(lastDate) ? lastDate : today);
    final firstDate = (isStart ? null : selectedStartDate) ?? (pastDate.isAfter(initialDate) ? initialDate : pastDate);

    final date = await showDatePicker(
      context: rootKey.currentContext!,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (date != null) {
      if (isStart) {
        setStartDate(date);
      } else {
        setDueDate(date);
      }
    }
  }

  void resetDate(String code) {
    if (code == 'startDate') {
      setStartDate(null);
    } else if (code == 'dueDate') {
      setDueDate(null);
    }
  }

  /// действия

  String get saveAndGoBtnTitle => (parent.isProject || parent.isRoot) ? loc.save_and_go_action_title : loc.save_and_repeat_action_title;

  Future<Task?> _saveTask() async => await taskUC.save(
        Task(
          id: task?.id,
          parent: parent,
          title: tfAnnoForCode('title').text,
          description: tfAnnoForCode('description').text,
          closed: task?.closed == true,
          statusId: selectedStatusId,
          priorityId: task?.priorityId,
          estimate: selectedEstimate?.value,
          startDate: selectedStartDate,
          dueDate: selectedDueDate,
          tasks: task?.tasks ?? [],
          type: task?.type,
          assigneeId: selectedAssignee?.id,
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
    final confirm = await showMTDialog(
      rootKey.currentContext!,
      title: task!.deleteDialogTitle,
      description: '${loc.task_delete_dialog_description}\n${loc.delete_dialog_description}',
      actions: [
        MTDialogAction(title: loc.yes, type: MTActionType.isDanger, result: true),
        MTDialogAction(title: loc.no, type: MTActionType.isDefault, result: false),
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

  /// оценки задач
  List<EstimateValue> get estimateValues => ws.estimateValues.toList();

  @observable
  int? selectedEstimateId;

  @action
  void selectEstimateId(int? id) => selectedEstimateId = id;
  void selectEstimateByValue(int? value) => selectEstimateId(estimateValues.firstWhereOrNull((e) => e.value == value)?.id);

  @computed
  EstimateValue? get selectedEstimate => estimateValues.firstWhereOrNull((e) => e.id == selectedEstimateId);
  @computed
  String? get estimateHelper => selectedEstimate == null && task?.estimate != null ? '${loc.task_estimate_placeholder}: ${task?.estimate}' : null;

  @computed
  bool get canEstimate => estimateValues.isNotEmpty && !parent.isRoot && (isNew || task!.isLeaf);

  /// назначенный
  @observable
  List<Member> allowedAssignees = [];

  @action
  void setAllowedAssignees(List<Member> assignees) => allowedAssignees = assignees;

  @observable
  int? selectedAssigneeId;

  @computed
  Member? get selectedAssignee => allowedAssignees.firstWhereOrNull((a) => a.id == selectedAssigneeId);

  @action
  void selectAssigneeId(int? id) => selectedAssigneeId = id;

  /// статусы задач

  @computed
  bool get canSetStatus => ws.statuses.isNotEmpty && (parent.isGoal || parent.isTask || parent.isSubtask) && (isNew || !task!.hasSubtasks);

  @observable
  int? selectedStatusId;

  @computed
  Status? get selectedStatus => ws.statuses.firstWhereOrNull((s) => s.id == selectedStatusId);

  @action
  void selectStatusId(int? id) {
    selectedStatusId = id;
    if (selectedStatus?.closed == true) {
      closed = true;
    }
  }

  // TODO: перенести элемент управления статусами в просмотр задачи и редактировать статус вместе с функцией закрытия из контроллера задачи

  @observable
  bool closed = false;

// @action
// void setClosed(bool? _closed) {
//   closed = _closed ?? false;
//   if (!closed && selectedStatus != null && selectedStatus!.closed) {
//     selectedStatusId = null; // не трогать
//   }
// }
}
