// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/api_schema/task_schema.dart';
import '../../../L1_domain/entities/status.dart';
import '../../../L1_domain/entities/task.dart';
import '../../components/mt_confirm_dialog.dart';
import '../../components/text_field_annotation.dart';
import '../../extra/services.dart';
import '../../presenters/date_presenter.dart';
import '../workspace/workspace_bounded.dart';

part 'task_edit_controller.g.dart';

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
  DateTime? _selectedDueDate;

  @action
  void setDueDate(DateTime? _date) {
    _selectedDueDate = _date;
    teControllers['dueDate']?.text = _date != null ? _date.strLong : '';
  }

  Future inputDateTime(BuildContext context) async {
    final firstDate = _selectedDueDate != null && DateTime.now().isAfter(_selectedDueDate!) ? _selectedDueDate! : DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: _selectedDueDate ?? DateTime.now(),
      firstDate: firstDate,
      lastDate: DateTime.now().add(const Duration(days: 36500)),
    );
    if (date != null) {
      setDueDate(date);
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
  @observable
  Task? taskForEdit;

  @action
  void selectTaskForEdit(Task? _t) => taskForEdit = _t;

  @computed
  bool get isNew => taskForEdit == null;

  @computed
  bool get isRoot => _parentId == null;

  @computed
  int? get _parentId => isNew
      ? taskViewController.isRoot
          ? null
          : taskViewController.selectedTask?.id
      : taskForEdit!.parentId;

  @override
  bool get validated => super.validated && selectedWS != null;

  @override
  void initState({List<TFAnnotation>? tfaList}) {
    super.initState(tfaList: tfaList);
    setDueDate(taskForEdit?.dueDate);
    setClosed(taskForEdit?.closed);
    selectWS(taskForEdit?.workspaceId);
    selectStatus(taskForEdit?.status);
  }

  /// действия

  Future save(BuildContext context) async {
    final editedTask = await tasksUC.save(TaskUpsert(
      id: taskForEdit?.id,
      parentId: _parentId,
      title: tfAnnoForCode('title').text,
      description: tfAnnoForCode('description').text,
      closed: closed,
      dueDate: _selectedDueDate,
      statusId: _selectedStatusId,
      workspaceId: selectedWS!.id,
    ));

    if (editedTask != null) {
      Navigator.of(context).pop(editedTask);
    }
  }

  Future delete(BuildContext context) async {
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
      final deletedTask = await tasksUC.delete(task: taskForEdit!);
      Navigator.of(context).pop(deletedTask);
    }
  }
}
