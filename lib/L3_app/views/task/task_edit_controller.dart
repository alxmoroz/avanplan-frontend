// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/api_schema/task_upsert.dart';
import '../../../L1_domain/entities/status.dart';
import '../../../L1_domain/entities/task.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_confirm_dialog.dart';
import '../../components/mt_dropdown.dart';
import '../../components/mt_text_field.dart';
import '../../components/text_field_annotation.dart';
import '../../components/text_widgets.dart';
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
      selectedStatusId = null;
    }
  }

  /// дата

  @observable
  DateTime? selectedDueDate;

  @action
  void setDueDate(DateTime? _date) {
    selectedDueDate = _date;
    controllers['dueDate']?.text = _date != null ? _date.strLong : '';
  }

  Future inputDateTime(BuildContext context) async {
    final firstDate = selectedDueDate != null && DateTime.now().isAfter(selectedDueDate!) ? selectedDueDate! : DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: selectedDueDate ?? DateTime.now(),
      firstDate: firstDate,
      lastDate: DateTime.now().add(const Duration(days: 36500)),
    );
    if (date != null) {
      setDueDate(date);
    }
  }

  Widget textFieldForCode(BuildContext context, String code, {VoidCallback? onTap}) {
    final ta = tfAnnoForCode(code);
    final isDate = code.endsWith('Date');
    return ta.noText
        ? MTTextField.noText(
            controller: controllers[code],
            label: ta.label,
            error: ta.errorText,
            onTap: onTap ?? (isDate ? () => inputDateTime(context) : null),
            suffixIcon: isDate ? calendarIcon(context) : null,
          )
        : MTTextField(
            controller: controllers[code],
            label: ta.label,
            error: ta.errorText,
            onTap: onTap,
          );
  }

  /// общий виджет - форма с полями для задач и целей

  Widget form(BuildContext context, [List<Widget>? customFields]) {
    return Scrollbar(
      thumbVisibility: true,
      child: ListView(children: [
        ...['title', 'dueDate', 'description'].map((code) => textFieldForCode(context, code)),
        if (customFields != null) ...customFields,
        Padding(
          padding: tfPadding,
          child: InkWell(
            child: Row(children: [
              doneIcon(context, closed),
              SizedBox(width: onePadding),
              MediumText(loc.common_mark_done_btn_title, padding: EdgeInsets.symmetric(vertical: onePadding)),
            ]),
            onTap: () => setClosed(!closed),
          ),
        ),
        if (canEdit) MTButton(loc.common_delete_btn_title, () => delete(context), titleColor: dangerColor, padding: EdgeInsets.only(top: onePadding)),
        SizedBox(height: onePadding),
      ]),
    );
  }

  @override
  void initState({List<TFAnnotation>? tfaList}) {
    super.initState(tfaList: tfaList);
    setDueDate(selectedTask?.dueDate);
    setClosed(selectedTask?.closed);
    selectWS(selectedTask?.workspaceId);
    selectStatus(selectedTask?.status);
  }

  /// статусы задач

  @computed
  List<Status> get statuses {
    final ws = mainController.workspaces.firstWhereOrNull((ws) => ws.id == selectedTask?.workspaceId);

    return ws != null ? ws.statuses : [];
  }

  @observable
  int? selectedStatusId;

  @action
  void selectStatus(Status? _status) {
    selectedStatusId = _status?.id;
    if (_status != null && _status.closed) {
      closed = true;
    }
  }

  @computed
  Status? get selectedStatus => statuses.firstWhereOrNull((s) => s.id == selectedStatusId);

  List<Widget> customFields(BuildContext context) {
    final items = <Widget>[];
    if (statuses.isNotEmpty) {
      items.add(MTDropdown<Status>(
        onChanged: (status) => selectStatus(status),
        value: selectedStatus,
        items: statuses,
        label: loc.common_status_placeholder,
      ));
    }
    return items;
  }

  /// выбранная задача
  @observable
  Task? selectedTask;

  @action
  void selectTask(Task? _ew) => selectedTask = _ew;

  @computed
  bool get canEdit => selectedTask != null;

  @computed
  int? get _parentId => canEdit ? taskViewController.selectedTask?.parentId : taskViewController.selectedTask?.id;

  @override
  bool get validated => super.validated && selectedWS != null;

  /// действия

  Future save(BuildContext context) async {
    final editedTask = await tasksUC.save(TaskUpsert(
      id: selectedTask?.id,
      parentId: _parentId,
      title: tfAnnoForCode('title').text,
      description: tfAnnoForCode('description').text,
      closed: closed,
      dueDate: selectedDueDate,
      statusId: selectedStatusId,
      workspaceId: selectedWS!.id,
    ));

    if (editedTask != null) {
      Navigator.of(context).pop(editedTask);
    }
  }

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
        final deletedEW = await tasksUC.delete(task: selectedTask!);
        Navigator.of(context).pop(deletedEW);
      }
    }
  }
}
