// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_dates.dart';
import '../../../../L1_domain/entities_extensions/task_params.dart';
import '../../../../L1_domain/entities_extensions/task_type.dart';
import '../../../components/field_data.dart';
import '../../../extra/services.dart';
import '../../../navigation/route.dart';
import '../../../navigation/router.dart';
import '../../../presenters/task_actions.dart';
import '../../../usecases/task_status.dart';
import '../../../views/_base/edit_controller.dart';
import '../../_base/loadable.dart';
import '../usecases/delete.dart';
import '../usecases/duplicate.dart';
import '../usecases/link.dart';
import '../usecases/status.dart';
import '../usecases/transfer.dart';
import '../widgets/details/task_details.dart';
import 'attachments_controller.dart';
import 'notes_controller.dart';
import 'project_modules_controller.dart';
import 'project_statuses_controller.dart';
import 'relations_controller.dart';
import 'subtasks_controller.dart';
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
  projectModules,
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
    projectModulesController = ProjectModulesController(this);
    projectStatusesController = ProjectStatusesController(this);

    setupFields();

    if (taskDescriptor.filled) {
      reloadContentControllers();
      stopLoading();
    }

    setLoaderScreenLoading();
  }

  void init(int wsId, int taskId, {String? type, MTRoute? route}) {
    initWithTask(
      tasksMainController.task(wsId, taskId) ??
          Task(
            wsId: wsId,
            id: taskId,
            type: type ?? TType.TASK,
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
            projectModules: [],
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
        MTFieldData(TaskFCode.projectModules.index, label: loc.project_modules_label),
        MTFieldData(TaskFCode.note.index),
        MTFieldData(TaskFCode.attachment.index, label: loc.attachments_label),
        MTFieldData(TaskFCode.finance.index, label: loc.tariff_option_finance_title, placeholder: loc.tariff_option_finance_title),
        MTFieldData(TaskFCode.relation.index, label: loc.task_relations_title, placeholder: loc.task_relations_title),
      ]);

  void reloadContentControllers() {
    relationsController.reload();
    attachmentsController.reload();
    notesController.reload();
    transactionsController.reload();
    subtasksController.reload();
    projectModulesController.reload();
    projectStatusesController.reload();
  }

  Future taskAction(BuildContext context, TaskAction? actionType) async {
    switch (actionType) {
      case TaskAction.details:
        await showDetailsDialog(this);
        break;
      case TaskAction.close:
        await setClosed(context, true);
        break;
      case TaskAction.reopen:
        await setClosed(context, false);
        break;
      case TaskAction.localExport:
        await localExport();
        break;
      case TaskAction.duplicate:
        await duplicate();
        break;
      // case TaskAction.go2source:
      //   await _task.go2source();
      //   break;
      case TaskAction.unlink:
        await unlink();
        break;
      case TaskAction.delete:
        await delete();
        break;
      default:
    }
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
}

abstract class _TaskControllerBase extends EditController with Store, Loadable {
  late Task taskDescriptor;

  late final RelationsController relationsController;
  late final AttachmentsController attachmentsController;
  late final NotesController notesController;
  late final TaskTransactionsController transactionsController;
  late final SubtasksController subtasksController;
  late final ProjectModulesController projectModulesController;
  late final ProjectStatusesController projectStatusesController;

  Task get task => tasksMainController.task(taskDescriptor.wsId, taskDescriptor.id) ?? taskDescriptor;

  Timer? textEditTimer;

  // TODO: чтобы сделать тут компьютед, нужно разобраться с обсервабле для задачи. Это может немного повысить производительность.

  late final bool _isPreview;
  bool get isPreview => _isPreview;
  bool get canEdit => !_isPreview && task.canEdit;
  bool get canDelete => !_isPreview && task.canDelete;
  bool get canCreateChecklist => !_isPreview && task.canCreateChecklist;
  bool get canSetStatus => !_isPreview && task.canSetStatus;
  bool get canAssign => !_isPreview && task.canAssign;
  bool get canShowAssigneeField => task.hasAssignee || canAssign;
  bool get canShowDateField => task.hasDates || canEdit;
  bool get canEstimate => !_isPreview && task.canEstimate;
  bool get canShowEstimateField => task.canShowEstimate || canEstimate;
  bool get canShowAttachmentsField => !_isPreview && task.attachments.isNotEmpty;
  bool get canEditFinance => !_isPreview && task.canEditFinance;
  bool get canShowFinanceField => transactionsController.hasTransactions || canEditFinance;
  bool get canShowRelationsField => relationsController.hasRelations || (!_isPreview && task.canEditRelations);
}
