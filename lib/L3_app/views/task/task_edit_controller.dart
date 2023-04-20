// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/estimate_value.dart';
import '../../../L1_domain/entities/member.dart';
import '../../../L1_domain/entities/task.dart';
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
  TaskEditController(Task _parent, Task? _task) {
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

    selectAssigneeById(task?.assigneeId);
    // selectStatus(task?.status);
    // selectType(task?.type);
  }
}

abstract class _TaskEditControllerBase extends EditController with Store {
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

  String get saveAndGoBtnTitle => (parent.isProject || parent.isWorkspace) ? loc.save_and_go_action_title : loc.save_and_repeat_action_title;

  Future<Task?> _saveTask() async => await taskUC.save(
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
          wsId: task?.wsId ?? mainController.selectedWSId!,
        ),
      );

  Future save({bool proceed = false}) async {
    loaderController.start();
    loaderController.setSaving();
    final editedTask = await _saveTask();
    if (editedTask != null) {
      Navigator.of(rootKey.currentContext!).pop(EditTaskResult(editedTask, proceed));
    }
    await loaderController.stop(300);
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
      loaderController.start();
      loaderController.setDeleting();
      final deletedTask = await taskUC.delete(task!);
      Navigator.of(rootKey.currentContext!).pop(EditTaskResult(deletedTask));
      await loaderController.stop(300);
    }
  }

  /// оценки задач
  List<EstimateValue> get estimateValues => mainController.selectedWS?.estimateValues.toList() ?? [];

  @observable
  int? _selectedEstimateId;

  @action
  void selectEstimate(EstimateValue? _est) => _selectedEstimateId = _est?.id;
  void selectEstimateByValue(int? value) => selectEstimate(estimateValues.firstWhereOrNull((e) => e.value == value));

  @computed
  EstimateValue? get selectedEstimate => estimateValues.firstWhereOrNull((e) => e.id == _selectedEstimateId);
  @computed
  String? get estimateHelper => selectedEstimate == null && task?.estimate != null ? '${loc.task_estimate_placeholder}: ${task?.estimate}' : null;

  @computed
  bool get canEstimate => estimateValues.isNotEmpty && !parent.isWorkspace && (isNew || task!.isLeaf);

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
