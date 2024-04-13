// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../../main.dart';
import '../../../components/field_data.dart';
import '../../../extra/router.dart';
import '../../../extra/services.dart';
import '../../../usecases/task_actions.dart';
import '../../../usecases/task_edit.dart';
import '../../../usecases/task_link.dart';
import '../../../views/_base/edit_controller.dart';
import '../task_view.dart';
import '../widgets/details/details_dialog.dart';
import '../widgets/local_transfer/local_export_controller.dart';
import 'assignee_controller.dart';
import 'attachments_controller.dart';
import 'dates_controller.dart';
import 'delete_controller.dart';
import 'duplicate_controller.dart';
import 'estimate_controller.dart';
import 'notes_controller.dart';
import 'project_statuses_controller.dart';
import 'status_controller.dart';
import 'subtasks_controller.dart';
import 'title_controller.dart';

part 'task_controller.g.dart';

enum TaskFCode { parent, title, status, assignee, description, startDate, dueDate, estimate, author, features, note, attachment }

enum TasksFilter { my, projects }

class TaskController extends _TaskControllerBase with _$TaskController {
  TaskController(Task taskIn, {bool isNew = false, bool? allowDisposeFromView}) {
    _task = taskIn;
    creating = isNew;

    initState(fds: [
      MTFieldData(TaskFCode.parent.index),
      MTFieldData(TaskFCode.status.index),
      MTFieldData(TaskFCode.title.index, text: creating == true ? '' : _task.title),
      MTFieldData(TaskFCode.assignee.index, label: loc.task_assignee_label, placeholder: loc.task_assignee_placeholder),
      MTFieldData(TaskFCode.description.index, text: _task.description, placeholder: loc.description),
      MTFieldData(TaskFCode.startDate.index, label: loc.task_start_date_label, placeholder: loc.task_start_date_placeholder),
      MTFieldData(TaskFCode.dueDate.index, label: loc.task_due_date_label, placeholder: loc.task_due_date_placeholder),
      MTFieldData(
        TaskFCode.estimate.index,
        label: (_task.isGroup || _task.isBacklog) ? loc.task_estimate_group_label : loc.task_estimate_label,
        placeholder: loc.task_estimate_placeholder,
      ),
      MTFieldData(TaskFCode.author.index, label: loc.task_author_title, placeholder: loc.task_author_title),
      MTFieldData(TaskFCode.features.index, label: loc.feature_sets_label),
      MTFieldData(TaskFCode.note.index),
      MTFieldData(TaskFCode.attachment.index, label: loc.attachments_label),
    ]);

    titleController = TitleController(this);
    assigneeController = AssigneeController(this);
    statusController = StatusController(this);
    datesController = DatesController(this);
    estimateController = EstimateController(this);
    attachmentsController = AttachmentsController(this);
    notesController = NotesController(this);
    projectStatusesController = ProjectStatusesController(this);
    localExportController = LocalExportController(this);
    subtasksController = SubtasksController(this);

    setAllowDisposeFromView(allowDisposeFromView);
  }

  Future showTask() async {
    loadTask();
    await MTRouter.navigate(TaskRouter, rootKey.currentContext!, args: this);
  }

  Future taskAction(TaskAction? actionType) async {
    switch (actionType) {
      case TaskAction.details:
        await showDetailsDialog(this);
        break;
      case TaskAction.close:
        await statusController.setStatus(_task, close: true);
        break;
      case TaskAction.reopen:
        await statusController.setStatus(_task, close: false);
        break;
      case TaskAction.localExport:
        await localExportController.localExport();
        break;
      case TaskAction.duplicate:
        await DuplicateController().duplicate(_task);
        break;
      // case TaskAction.go2source:
      //   await _task.go2source();
      //   break;
      case TaskAction.unlink:
        await _task.unlink();
        break;
      case TaskAction.delete:
        await DeleteController().delete(_task);
        break;
      default:
    }
  }
}

abstract class _TaskControllerBase extends EditController with Store {
  late final Task _task;
  late final TitleController titleController;
  late final AssigneeController assigneeController;
  late final StatusController statusController;
  late final DatesController datesController;
  late final EstimateController estimateController;

  late final ProjectStatusesController projectStatusesController;
  late final LocalExportController localExportController;

  late final SubtasksController subtasksController;
  late final NotesController notesController;
  late final AttachmentsController attachmentsController;

  Task? get task => tasksMainController.task(_task.wsId, _task.id);

  @observable
  bool creating = false;

  void _setTaskContentControllers() {
    subtasksController.setData();
    attachmentsController.setData();
    notesController.setData();
  }

  @action
  Future loadTask() async {
    if (task != null && !task!.filled) {
      await task!.load();
      _setTaskContentControllers();
    }
  }

  Future<bool> saveField(TaskFCode code) async {
    updateField(code.index, loading: true);
    final et = await task?.save();
    final saved = et != null;
    updateField(code.index, loading: false);
    return saved;
  }

  /// режим Доска / Список

  @observable
  bool showBoard = true;
  @action
  void toggleBoardMode() => showBoard = !showBoard;
}
