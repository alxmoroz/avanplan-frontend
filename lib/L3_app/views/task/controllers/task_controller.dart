// Copyright (c) 2023. Alexandr Moroz

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../../main.dart';
import '../../../components/field_data.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_view.dart';
import '../../../usecases/task_edit.dart';
import '../../../usecases/task_tree.dart';
import '../../../views/_base/edit_controller.dart';
import '../task_view.dart';
import '../widgets/transfer/local_export_controller.dart';
import 'assignee_controller.dart';
import 'attachments_controller.dart';
import 'dates_controller.dart';
import 'estimate_controller.dart';
import 'notes_controller.dart';
import 'project_statuses_controller.dart';
import 'status_controller.dart';
import 'subtasks_controller.dart';
import 'title_controller.dart';

part 'task_controller.g.dart';

enum TaskTabKey { overview, subtasks, details, team }

enum TaskFCode { parent, title, status, assignee, description, startDate, dueDate, type, estimate, author, features, statuses, note, attachment }

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
      MTFieldData(TaskFCode.description.index, text: _task.description, label: loc.description, placeholder: loc.description),
      MTFieldData(TaskFCode.startDate.index, label: loc.task_start_date_label, placeholder: loc.task_start_date_placeholder),
      MTFieldData(TaskFCode.dueDate.index, label: loc.task_due_date_label, placeholder: loc.task_due_date_placeholder),
      MTFieldData(TaskFCode.type.index),
      MTFieldData(
        TaskFCode.estimate.index,
        label: _task.openedVolume != null ? loc.task_estimate_group_label : loc.task_estimate_label,
        placeholder: loc.task_estimate_placeholder,
      ),
      MTFieldData(TaskFCode.author.index, label: loc.task_author_title, placeholder: loc.task_author_title),
      MTFieldData(TaskFCode.features.index, label: loc.feature_sets_label),
      MTFieldData(TaskFCode.statuses.index, label: loc.status_list_title, placeholder: loc.status_list_title),
      MTFieldData(TaskFCode.note.index, placeholder: loc.task_note_placeholder),
      MTFieldData(TaskFCode.attachment.index, label: loc.attachments_label),
    ]);

    titleController = TitleController(this);
    assigneeController = AssigneeController(this);
    statusController = StatusController(this);
    datesController = DatesController(this);
    estimateController = EstimateController(this);
    notesController = NotesController(this);
    projectStatusesController = ProjectStatusesController(this);
    attachmentsController = AttachmentsController(this);
    transferController = LocalExportController(this);
    subtasksController = SubtasksController(this);

    setAllowDisposeFromView(allowDisposeFromView);
  }

  Future showTask() async {
    //TODO: нужно ли в этом месте создавать контроллер, может, тут достаточно отправить айдишники?
    await TaskRouter().navigate(rootKey.currentContext!, args: this);
  }
}

abstract class _TaskControllerBase extends EditController with Store {
  late final Task _task;
  late final TitleController titleController;
  late final AssigneeController assigneeController;
  late final StatusController statusController;
  late final DatesController datesController;
  late final EstimateController estimateController;
  late final NotesController notesController;
  late final ProjectStatusesController projectStatusesController;
  late final AttachmentsController attachmentsController;
  late final LocalExportController transferController;
  late final SubtasksController subtasksController;

  Task get task => tasksMainController.task(_task.wsId, _task.id)!;

  @observable
  bool creating = false;

  Future<bool> saveField(TaskFCode code) async {
    updateField(code.index, loading: true);
    final et = await task.save();
    final saved = et != null;
    updateField(code.index, loading: false);
    return saved;
  }

  /// вкладки

  @computed
  Iterable<TaskTabKey> get tabKeys {
    return [
      if (task.hasOverviewPane) TaskTabKey.overview,
      if (!task.isTask || task.isCheckList) TaskTabKey.subtasks,
      if (task.hasTeamPane) TaskTabKey.team,
      TaskTabKey.details,
    ];
  }

  @observable
  TaskTabKey? _tabKey;
  @action
  void selectTab(TaskTabKey? tk) {
    _tabKey = tk;
    FocusScope.of(rootKey.currentContext!).unfocus();
  }

  @computed
  TaskTabKey get tabKey => (tabKeys.contains(_tabKey) ? _tabKey : null) ?? (tabKeys.isNotEmpty ? tabKeys.first : TaskTabKey.subtasks);

  /// режим Доска / Список

  @observable
  bool showBoard = true;
  @action
  void toggleMode() => showBoard = !showBoard;
}
