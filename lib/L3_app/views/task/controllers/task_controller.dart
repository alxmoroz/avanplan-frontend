// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_dates.dart';
import '../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../L1_domain/entities_extensions/task_type.dart';
import '../../../components/field_data.dart';
import '../../../extra/services.dart';
import '../../../navigation/route.dart';
import '../../../navigation/router.dart';
import '../../../presenters/task_actions.dart';
import '../../../presenters/task_tree.dart';
import '../../../usecases/task_status.dart';
import '../../../views/_base/edit_controller.dart';
import '../../_base/loadable.dart';
import 'attachments_controller.dart';
import 'notes_controller.dart';
import 'project_statuses_controller.dart';
import 'relations_controller.dart';
import 'subtasks_controller.dart';
import 'task_settings_controller.dart';
import 'task_transactions_controller.dart';

part 'task_controller.g.dart';

enum TaskFCode {
  parent,
  title,
  assignee,
  description,
  status,
  startDate,
  dueDate,
  repeat,
  estimate,
  author,
  note,
  attachment,
  finance,
  relation,
}

class TaskController extends _TaskControllerBase with _$TaskController {
  TaskController({Task? taskIn, bool isPreview = false}) {
    _isPreview = isPreview;
    if (taskIn != null) initWithTask(taskIn);
  }

  MTRoute? route;
  final notesWidgetGlobalKey = GlobalKey();

  void initWithTask(Task taskIn) {
    taskDescriptor = taskIn;

    relationsController = RelationsController(this);
    attachmentsController = AttachmentsController(this);
    notesController = NotesController(this);
    transactionsController = TaskTransactionsController(this);
    subtasksController = SubtasksController(this);
    projectStatusesController = ProjectStatusesController(this);
    settingsController = TaskSettingsController(this);

    setupFields();

    if (taskDescriptor.filled) {
      reloadContentControllers();
      stopLoading();
    }

    setLoaderScreenLoading();
  }

  void init(int wsId, int taskId, {TType type = TType.TASK, MTRoute? route}) {
    initWithTask(
      tasksMainController.task(wsId, taskId) ??
          Task(
            wsId: wsId,
            id: taskId,
            type: type,
            title: '',
            startDate: null,
            closed: false,
            parentId: null,
            relations: [],
            notes: [],
            attachments: [],
            transactions: [],
            income: 0,
            expenses: 0,
            members: [],
            projectStatuses: [],
          ),
    );
    this.route = route;
  }

  void setupFields() => initState(fds: [
        MTFieldData(TaskFCode.parent.index),
        MTFieldData(TaskFCode.title.index, text: taskDescriptor.creating ? '' : taskDescriptor.title),
        MTFieldData(TaskFCode.assignee.index, label: loc.task_assignee_label, placeholder: loc.task_assignee_placeholder),
        MTFieldData(TaskFCode.description.index, text: taskDescriptor.description, placeholder: loc.description),
        MTFieldData(TaskFCode.status.index, text: '${taskDescriptor.status}', label: loc.status_title, placeholder: loc.status_title),
        MTFieldData(TaskFCode.startDate.index, label: loc.task_start_date_label, placeholder: loc.task_start_date_placeholder),
        MTFieldData(TaskFCode.dueDate.index, label: loc.task_due_date_label, placeholder: loc.task_due_date_placeholder),
        MTFieldData(TaskFCode.repeat.index, placeholder: loc.task_repeat_placeholder),
        MTFieldData(
          TaskFCode.estimate.index,
          label: taskDescriptor.isGroup ? loc.task_estimate_group_label : loc.task_estimate_label,
          placeholder: loc.task_estimate_placeholder,
        ),
        MTFieldData(TaskFCode.author.index, label: loc.task_author_title, placeholder: loc.task_author_title),
        MTFieldData(TaskFCode.note.index),
        MTFieldData(TaskFCode.attachment.index, label: loc.attachments_label),
        MTFieldData(TaskFCode.finance.index, label: loc.tariff_option_finance_title, placeholder: loc.tariff_option_finance_title),
        MTFieldData(TaskFCode.relation.index, label: loc.relations_title, placeholder: loc.relations_title),
      ]);

  void reloadContentControllers() {
    relationsController.reload();
    attachmentsController.reload();
    notesController.reload();
    transactionsController.reload();
    subtasksController.reload();
    projectStatusesController.reload();
    settingsController.reload();
  }

  @override
  void parseError(Exception e) {
    // 404
    if (e is DioException && e.type == DioExceptionType.badResponse && e.response?.statusCode == 404) {
      tasksMainController.removeTask(task);
      tasksMainController.refreshUI();
      router.goTask404(route?.parent);
    } else {
      super.parseError(e);
    }
  }

  late Task taskDescriptor;

  late final RelationsController relationsController;
  late final AttachmentsController attachmentsController;
  late final NotesController notesController;
  late final TaskTransactionsController transactionsController;
  late final SubtasksController subtasksController;
  late final ProjectStatusesController projectStatusesController;
  late final TaskSettingsController settingsController;

  Task get task => tasksMainController.task(taskDescriptor.wsId, taskDescriptor.id) ?? taskDescriptor;

  Timer? textEditTimer;

  // TODO: чтобы сделать тут компьютед, нужно разобраться с обсервабле для задачи. Это может немного повысить производительность.

  late final bool _isPreview;
  bool get isPreview => _isPreview;
  bool get canEdit => !_isPreview && task.canEdit;
  bool get canCreate => !_isPreview && task.canCreate;
  bool get _canClose => !_isPreview && task.canClose;
  bool get _canReopen => !_isPreview && task.canReopen;
  bool get _canLocalExport => !_isPreview && task.canLocalExport;
  bool get _canLocalImport => !_isPreview && task.canLocalImport;
  bool get _canDuplicate => !_isPreview && task.canDuplicate;
  bool get canDelete => !_isPreview && task.canDelete;
  bool get canCreateChecklist => !_isPreview && task.canCreateChecklist;
  bool get canSetStatus => !_isPreview && task.canSetStatus;
  bool get canAssign => canEdit && task.activeMembers.isNotEmpty;
  bool get canShowDateField => task.hasDates || canEdit;
  bool get canShowDueDateField => task.hasDueDate || canEdit;
  bool get canShowStartDateField => task.hasStartDate || canEdit;
  bool get canShowRepeatField => task.hasRepeat || (task.isTask && canEdit);
  bool get canEstimate => !_isPreview && task.canEstimate;
  bool get canShowAttachmentsField => !_isPreview && task.attachments.isNotEmpty;
  bool get canEditFinance => !_isPreview && task.canEditFinance;
  bool get canEditRelations => !_isPreview && task.canEditRelations;
  bool get canComment => !_isPreview && task.canComment;

  Iterable<TaskAction> actions(BuildContext context, {bool inToolbar = false}) {
    final t = task;
    final showDetails = !inToolbar && t.canShowDetails(context);

    final paramsActions = [
      TaskAction.assignee,
      if (t.isTask) TaskAction.estimate,
      TaskAction.finance,
      if (t.isTask) TaskAction.relations,
    ];

    // задачу можно закрыть / переоткрыть через кружочек, поэтому для задачи в меню нет Закрыть / Переоткрыть, а для групп - есть
    final showClose = !t.isTask && _canClose;
    final showReopen = !t.isTask && _canReopen;
    final showLocalExport = _canLocalExport;
    final showLocalImport = _canLocalImport;
    final showDuplicate = _canDuplicate;
    final hasActions = showClose || showReopen || showLocalExport || showLocalImport || showDuplicate;

    final showDelete = canDelete;

    return [
      if (showDetails) TaskAction.details,
      //
      if (paramsActions.isNotEmpty && showDetails) TaskAction.divider,
      ...paramsActions,
      //
      if (hasActions && (showDetails || paramsActions.isNotEmpty)) TaskAction.divider,
      if (showClose) TaskAction.close,
      if (showReopen) TaskAction.reopen,
      if (showLocalExport) TaskAction.localExport,
      if (showLocalImport) TaskAction.localImport,
      if (showDuplicate) TaskAction.duplicate,
      //
      if (showDelete && (showDetails || hasActions || paramsActions.isNotEmpty)) TaskAction.divider,
      if (showDelete) TaskAction.delete,
    ];
  }

  Iterable<TaskAction> get quickActions => [
        if (task.isInboxTask && _canLocalExport) TaskAction.localExport,
      ];
}

abstract class _TaskControllerBase extends EditController with Store, Loadable {}
