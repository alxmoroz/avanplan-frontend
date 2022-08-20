// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/task_ext_state.dart';
import '../../../L1_domain/entities/task_source.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../components/icons.dart';
import '../../components/mt_confirm_dialog.dart';
import '../../extra/services.dart';
import '../../presenters/task_source_presenter.dart';
import '../_base/base_controller.dart';
import '../task/task_edit_view.dart';
import '../task/task_view.dart';

part 'task_view_controller.g.dart';

class TaskViewController extends _TaskViewControllerBase with _$TaskViewController {}

abstract class _TaskViewControllerBase extends BaseController with Store {
  /// рутовый объект
  @observable
  Task rootTask = Task(
    title: '',
    parent: null,
    tasks: [],
    description: '',
    closed: false,
    createdOn: DateTime.now(),
    updatedOn: DateTime.now(),
  );

  /// история переходов и текущая выбранная задача
  @observable
  ObservableList<Task> navStack = ObservableList();

  @computed
  int? get _selectedTaskId => navStack.isNotEmpty ? navStack.last.id : null;

  @computed
  Task get selectedTask => taskForId(_selectedTaskId);

  Task taskForId(int? id) => rootTask.allTasks.firstWhereOrNull((t) => t.id == id) ?? rootTask;

  @action
  void _pushTask(Task _task) => navStack.add(_task);

  @action
  void _popTask() {
    if (navStack.isNotEmpty) {
      navStack.removeLast();
    }
  }

  @override
  bool get isLoading => super.isLoading || mainController.isLoading;

  @action
  Future fetchData() async {
    final tasks = <Task>[];
    for (Workspace ws in mainController.workspaces) {
      if (ws.id != null) {
        tasks.addAll(await tasksUC.getRoots(ws.id!));
      }
    }
    tasks.forEach((t) => t.parent = rootTask);
    rootTask.tasks = tasks;

    rootTask = rootTask.copy();
    // TODO: чтобы сохранять положение в навигации внутри приложения, нужно отправлять набор хлебных крошек на сервер в профиль пользователя
    // TODO: а также нужно проверять корректность пути этого при загрузке, чтобы не было зацикливаний, обрывов и т.п.
    navStack.clear();
  }

  @action
  void clearData() {
    navStack.clear();
    rootTask.tasks = [];
  }

  void _updateParentTask(Task _task) {
    final _parent = _task.parent;
    if (_parent != null) {
      final index = _parent.tasks.indexWhere((t) => t.id == _task.id);
      if (index >= 0) {
        if (_task.deleted) {
          _parent.tasks.removeAt(index);
        } else {
          //TODO: проверить необходимость в copy
          _parent.tasks[index] = _task.copy();
        }
      }
      rootTask = rootTask.copy();
    }
  }

  void _updateParents(Task _task) {
    final _parent = _task.parent;
    if (_parent != null) {
      _updateParents(_parent);
    }
    _updateParentTask(_task);
  }

  /// связь с источником импорта

  Future<bool> _checkUnlinked(BuildContext context) async {
    bool unlinked = !selectedTask.hasLink;
    if (!unlinked) {
      if (await _unlinkDialog(context) ?? false) {
        unlinked = await _unlink();
      }
    }
    return unlinked;
  }

  Future<bool?> _unlinkDialog(BuildContext context) async => await showMTDialog<bool?>(
        context,
        title: loc.task_unlink_dialog_title,
        description: loc.task_unlink_dialog_description,
        actions: [
          MTDialogAction(
            title: loc.task_unlink_action_title,
            type: MTActionType.isWarning,
            result: true,
            icon: unlinkIcon(context),
          ),
          MTDialogAction(
            type: MTActionType.isDefault,
            onTap: () => launchUrl(selectedTask.taskSource!.uri),
            result: false,
            child: selectedTask.taskSource!.go2SourceTitle(context),
          ),
        ],
      );

  Iterable<TaskSource> _unlinkTaskTree(Task t) {
    final tss = <TaskSource>[];
    for (Task subtask in t.tasks) {
      tss.addAll(_unlinkTaskTree(subtask));
    }
    if (t.hasLink) {
      t.taskSource?.keepConnection = false;
      tss.add(t.taskSource!);
    }
    return tss;
  }

  Future<bool> _unlink() async {
    startLoading();
    final res = await importUC.updateTaskSources(_unlinkTaskTree(selectedTask));
    stopLoading();
    return res;
  }

  /// роутер
  Future showTask(BuildContext context, Task _t) async {
    _pushTask(_t);
    await Navigator.of(context).pushNamed(TaskView.routeName);
    _popTask();
  }

  Future addTask(BuildContext context) async {
    if (await _checkUnlinked(context)) {
      final newTask = await editTaskDialog(context);
      if (newTask != null) {
        selectedTask.tasks.add(newTask);
        _updateParents(newTask);
      }
    }
  }

  Future editTask(BuildContext context) async {
    if (await _checkUnlinked(context)) {
      final editedTask = await editTaskDialog(context, selectedTask);
      if (editedTask != null) {
        if (editedTask.deleted) {
          Navigator.of(context).pop();
        }
        _updateParents(editedTask);
      }
    }
  }

  Future setTaskClosed(BuildContext context, Task task, bool closed) async {
    task.closed = closed;
    final editedTask = await tasksUC.save(task);
    if (editedTask != null) {
      if (editedTask.closed) {
        Navigator.of(context).pop(editedTask);
      }
      _updateParents(editedTask);
    }
  }
}
