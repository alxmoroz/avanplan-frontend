// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../components/field_data.dart';
import '../../../extra/services.dart';
import '../../../usecases/task_actions.dart';
import '../../../usecases/task_edit.dart';
import '../../../views/_base/edit_controller.dart';
import '../../projects/create_project_quiz_controller.dart';
import '../../quiz/abstract_task_quiz_controller.dart';
import '../widgets/details/details_dialog.dart';
import '../widgets/local_transfer/local_export_controller.dart';
import 'assignee_controller.dart';
import 'attachments_controller.dart';
import 'create_goal_quiz_controller.dart';
import 'dates_controller.dart';
import 'delete_controller.dart';
import 'duplicate_controller.dart';
import 'estimate_controller.dart';
import 'feature_sets_controller.dart';
import 'link_controller.dart';
import 'notes_controller.dart';
import 'project_statuses_controller.dart';
import 'status_controller.dart';
import 'subtasks_controller.dart';
import 'title_controller.dart';

part 'task_controller.g.dart';

enum TaskFCode { parent, title, assignee, description, startDate, dueDate, estimate, author, features, note, attachment }

enum TasksFilter { my, projects }

class TaskController extends _TaskControllerBase with _$TaskController {
  TaskController(Task taskIn, {bool isNew = false}) {
    taskDescriptor = taskIn;
    creating = isNew;

    initState(fds: [
      MTFieldData(TaskFCode.parent.index),
      MTFieldData(TaskFCode.title.index, text: creating == true ? '' : taskDescriptor.title),
      MTFieldData(TaskFCode.assignee.index, label: loc.task_assignee_label, placeholder: loc.task_assignee_placeholder),
      MTFieldData(TaskFCode.description.index, text: taskDescriptor.description, placeholder: loc.description),
      MTFieldData(TaskFCode.startDate.index, label: loc.task_start_date_label, placeholder: loc.task_start_date_placeholder),
      MTFieldData(TaskFCode.dueDate.index, label: loc.task_due_date_label, placeholder: loc.task_due_date_placeholder),
      MTFieldData(
        TaskFCode.estimate.index,
        label: (taskDescriptor.isGroup || taskDescriptor.isBacklog) ? loc.task_estimate_group_label : loc.task_estimate_label,
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
    subtasksController = SubtasksController(this);
    featureSetsController = FeatureSetsController(this);

    projectStatusesController = ProjectStatusesController(this);
    localExportController = LocalExportController(this);

    linkController = LinkController(this);
    duplicateController = DuplicateController(this);
    deleteController = DeleteController(this);

    quizController = isNew
        ? taskDescriptor.isProject
            ? CreateProjectQuizController(this)
            : taskDescriptor.isGoal
                ? CreateGoalQuizController(this)
                : null
        : null;
  }

  Future taskAction(BuildContext context, TaskAction? actionType) async {
    switch (actionType) {
      case TaskAction.details:
        await showDetailsDialog(this);
        break;
      case TaskAction.close:
        await statusController.setClosed(context, true);
        break;
      case TaskAction.reopen:
        await statusController.setClosed(context, false);
        break;
      case TaskAction.localExport:
        await localExportController.localExport(context);
        break;
      case TaskAction.duplicate:
        await duplicateController.duplicate(context);
        break;
      // case TaskAction.go2source:
      //   await _task.go2source();
      //   break;
      case TaskAction.unlink:
        await linkController.unlink(context);
        break;
      case TaskAction.delete:
        await deleteController.delete(context);
        break;
      default:
    }
  }
}

abstract class _TaskControllerBase extends EditController with Store {
  late final Task taskDescriptor;
  late final TitleController titleController;
  late final AssigneeController assigneeController;
  late final StatusController statusController;
  late final DatesController datesController;
  late final EstimateController estimateController;

  late final AttachmentsController attachmentsController;
  late final NotesController notesController;
  late final SubtasksController subtasksController;
  late final FeatureSetsController featureSetsController;

  late final ProjectStatusesController projectStatusesController;
  late final LocalExportController localExportController;

  late final LinkController linkController;
  late final DuplicateController duplicateController;
  late final DeleteController deleteController;

  AbstractTaskQuizController? quizController;

  Task? get task => tasksMainController.task(taskDescriptor.wsId, taskDescriptor.id);

  @observable
  bool creating = false;

  void _setTaskContentControllers() {
    subtasksController.reload();
    attachmentsController.reload();
    notesController.reload();
  }

  Future loadTask({bool force = false}) async {
    if (task != null && (!task!.filled || force)) {
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
