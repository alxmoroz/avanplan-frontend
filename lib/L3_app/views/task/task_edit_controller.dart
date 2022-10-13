// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/status.dart';
import '../../../L1_domain/entities/task.dart';
import '../../components/mt_confirm_dialog.dart';
import '../../extra/services.dart';
import '../../presenters/date_presenter.dart';
import '../../presenters/task_level_presenter.dart';
import '../workspace/workspace_bounded.dart';

part 'task_edit_controller.g.dart';

const _year = Duration(days: 365);

class TaskEditController extends _TaskEditControllerBase with _$TaskEditController {}

abstract class _TaskEditControllerBase extends WorkspaceBounded with Store {
  @observable
  bool closed = false;

  @action
  void setClosed(bool? _closed) {
    closed = _closed ?? false;
    if (!closed && selectedStatus != null && selectedStatus!.closed) {
      _selectedStatusId = null; // не трогать
    }
  }

  /// дата

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
    // final isDue = code == 'dueDate';

    final today = DateTime.now();
    final initialDate = (isStart ? selectedStartDate : selectedDueDate) ?? today;
    final pastDate = today.subtract(_year);
    final firstDate = (isStart ? null : selectedStartDate) ?? (pastDate.isAfter(initialDate) ? initialDate : pastDate);
    final lastDate = (isStart ? selectedDueDate : null) ?? today.add(_year * 100);

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

  /// статусы задач
  @computed
  List<Status> get statuses => selectedWS?.statuses ?? [];

  @observable
  int? _selectedStatusId;

  @action
  void selectStatus(Status? _status) {
    _selectedStatusId = _status?.id;
    if (_status != null && _status.closed) {
      closed = true;
    }
  }

  @computed
  Status? get selectedStatus => statuses.firstWhereOrNull((s) => s.id == _selectedStatusId);

  /// выбранная задача для редактирования

  @override
  bool get validated => super.validated && selectedWS != null;

  /// действия

  Future save(BuildContext context, {Task? task, required Task parent}) async {
    startLoading();
    final editedTask = await tasksUC.save(Task(
      id: task?.id,
      parent: parent,
      title: tfAnnoForCode('title').text,
      description: tfAnnoForCode('description').text,
      closed: closed,
      startDate: selectedStartDate,
      dueDate: selectedDueDate,
      status: selectedStatus,
      workspaceId: selectedWS!.id,
      tasks: task?.tasks ?? [],
    ));
    stopLoading();

    if (editedTask != null) {
      Navigator.of(context).pop(editedTask);
    }
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
      startLoading();
      final deletedTask = await tasksUC.delete(t: task);
      stopLoading();
      Navigator.of(context).pop(deletedTask);
    }
  }
}
