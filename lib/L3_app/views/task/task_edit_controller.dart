// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/estimate_value.dart';
import '../../../L1_domain/entities/member.dart';
import '../../../L1_domain/entities/task.dart';
import '../../components/mt_confirm_dialog.dart';
import '../../extra/services.dart';
import '../../presenters/date_presenter.dart';
import '../../presenters/task_level_presenter.dart';
import '../workspace/workspace_bounded.dart';
import 'task_edit_view.dart';

part 'task_edit_controller.g.dart';

const _year = Duration(days: 365);

class TaskEditController = _TaskEditControllerBase with _$TaskEditController;

abstract class _TaskEditControllerBase extends WorkspaceBounded with Store {
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

  Future selectDate(BuildContext context, String code) async {
    final isStart = code == 'startDate';

    final today = DateTime.now();
    final pastDate = today.subtract(_year);
    final lastDate = (isStart ? selectedDueDate?.subtract(const Duration(days: 1)) : null) ?? today.add(_year * 100);
    final initialDate = (isStart ? selectedStartDate : selectedDueDate) ?? (today.isAfter(lastDate) ? lastDate : today);
    final firstDate = (isStart ? null : selectedStartDate) ?? (pastDate.isAfter(initialDate) ? initialDate : pastDate);

    final date = await showDatePicker(
      context: context,
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

  /// выбранная задача для редактирования

  @override
  bool get validated => super.validated && selectedWS != null;

  /// действия
  Future<Task?> _saveTask(Task? task, Task parent) async => await taskUC.save(
        Task(
          id: task?.id,
          parent: parent,
          title: tfAnnoForCode('title').text,
          description: tfAnnoForCode('description').text,
          closed: task?.closed == true,
          status: task?.status,
          priority: task?.priority,
          estimate: selectedEstimate?.value,
          startDate: selectedStartDate,
          dueDate: selectedDueDate,
          tasks: task?.tasks ?? [],
          type: task?.type,
          assigneeId: selectedAssignee?.id,
          authorId: task?.authorId,
          members: task?.members ?? [],
          wsId: selectedWS!.id!,
        ),
      );

  Future save(BuildContext context, {Task? task, required Task parent, bool proceed = false}) async {
    loaderController.start();
    loaderController.setSaving();
    final editedTask = await _saveTask(task, parent);
    if (editedTask != null) {
      Navigator.of(context).pop(EditTaskResult(editedTask, proceed));
    }
    await loaderController.stop(300);
  }

  Future delete(BuildContext context, Task task) async {
    final confirm = await showMTDialog<bool?>(
      context,
      title: task.deleteDialogTitle,
      description: '${loc.task_delete_dialog_description}\n${loc.delete_dialog_description}',
      actions: [
        MTDialogAction(title: loc.yes, type: MTActionType.isDanger, result: true),
        MTDialogAction(title: loc.no, type: MTActionType.isDefault, result: false),
      ],
      simple: true,
    );
    if (confirm == true) {
      loaderController.start();
      loaderController.setDeleting();
      final deletedTask = await taskUC.delete(task);
      Navigator.of(context).pop(EditTaskResult(deletedTask));
      await loaderController.stop(300);
    }
  }

  /// оценки задач
  @computed
  Iterable<EstimateValue> get estimateValues => selectedWS?.estimateValues ?? [];

  @observable
  int? _selectedEstimateId;

  @action
  void selectEstimate(EstimateValue? _est) => _selectedEstimateId = _est?.id;
  void selectEstimateByValue(int? value) => selectEstimate(estimateValues.firstWhereOrNull((e) => e.value == value));

  @computed
  EstimateValue? get selectedEstimate => estimateValues.firstWhereOrNull((e) => e.id == _selectedEstimateId);

  /// назначенный
  @observable
  List<Member> allowedAssignees = [];

  @action
  void setAllowedAssignees(List<Member> assignees) => allowedAssignees = assignees;

  @observable
  Member? selectedAssignee;

  @action
  void selectAssignee(Member? ass) => selectedAssignee = ass;
  void selectAssigneeById(int? id) => selectAssignee(allowedAssignees.firstWhereOrNull((m) => m.id == id));

  /// статусы задач

  // @observable
  // bool closed = false;
  //
  // @action
  // void setClosed(bool? _closed) {
  //   closed = _closed ?? false;
  //   if (!closed && selectedStatus != null && selectedStatus!.closed) {
  //     _selectedStatusId = null; // не трогать
  //   }
  // }

  // @computed
  // List<Status> get statuses => selectedWS?.statuses ?? [];
  //
  // @observable
  // int? _selectedStatusId;
  //
  // @action
  // void selectStatus(Status? _status) {
  //   _selectedStatusId = _status?.id;
  //   if (_status != null && _status.closed) {
  //     closed = true;
  //   }
  // }

  // @computed
  // Status? get selectedStatus => statuses.firstWhereOrNull((s) => s.id == _selectedStatusId);

  /// тип задачи
  // @observable
  // int? selectedTypeId;

  // @action
  // void selectType(TaskType? _type) => selectedTypeId = _type?.id;

  // @computed
  // TaskType? get selectedType => referencesController.taskTypes.firstWhereOrNull((t) => t.id == selectedTypeId);

  // @computed
  // bool get isBacklog => selectedType?.title == 'backlog';

  // void toggleBacklog() {
  //   final type = referencesController.taskTypes.firstWhereOrNull((t) => t.title == (isBacklog ? 'goal' : 'backlog'));
  //   selectType(type);
  // }
}
