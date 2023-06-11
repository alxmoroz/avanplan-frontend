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
import '../../components/mt_alert_dialog.dart';
import '../../components/text_field_annotation.dart';
import '../../extra/services.dart';
import '../../presenters/task_level_presenter.dart';
import '../../usecases/task_ext_actions.dart';
import '../../views/_base/edit_controller.dart';
import 'task_edit_view.dart';

part 'task_edit_controller.g.dart';

class TaskEditController extends _TaskEditControllerBase with _$TaskEditController {
  TaskEditController(int _wsId, {required Task parent, Task? task}) {
    wsId = _wsId;
    this.parent = parent;
    this.task = task;
    isNew = task == null;

    initState(tfaList: [
      TFAnnotation('title', label: loc.title, text: task?.title ?? ''),
      TFAnnotation('description', label: loc.description, text: task?.description ?? '', needValidate: false),
    ]);

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
      selectedStatusId = task?.statusId ?? ws.statuses.firstOrNull?.id;
    }
  }
}

abstract class _TaskEditControllerBase extends EditController with Store {
  late final int wsId;
  late final Task parent;
  late final Task? task;
  late final bool isNew;

  /// действия

  String get saveAndGoBtnTitle => (parent.isProject || parent.isRoot) ? loc.save_and_go_action_title : loc.save_and_repeat_action_title;

  Future<Task?> _saveTask() async => await taskUC.save(
        Task(
          id: task?.id,
          parent: parent,
          title: tfa('title').text,
          description: tfa('description').text,
          closed: task?.closed == true,
          statusId: selectedStatusId,
          estimate: selectedEstimate?.value,
          startDate: task?.startDate,
          dueDate: task?.dueDate,
          tasks: task?.tasks ?? [],
          type: task?.type,
          assigneeId: selectedAssigneeId,
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
    final confirm = await showMTAlertDialog(
      rootKey.currentContext!,
      title: task!.deleteDialogTitle,
      description: '${loc.task_delete_dialog_description}\n${loc.delete_dialog_description}',
      actions: [
        MTADialogAction(title: loc.yes, type: MTActionType.isDanger, result: true),
        MTADialogAction(title: loc.no, type: MTActionType.isDefault, result: false),
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
  bool get canSetStatus => ws.statuses.isNotEmpty && (parent.isGoal || parent.isTask || parent.isSubtask) && (isNew || task!.isTrueLeaf);

  @observable
  int? selectedStatusId;

  @computed
  Status? get selectedStatus => ws.statuses.firstWhereOrNull((s) => s.id == selectedStatusId);
}
