// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/task_ext_actions.dart';
import '../../L1_domain/entities/task_ext_state.dart';
import '../../L1_domain/entities/task_source.dart';
import '../components/icons.dart';
import '../components/mt_confirm_dialog.dart';
import '../extra/services.dart';
import '../views/task/task_edit_view.dart';
import 'task_source_presenter.dart';

extension TaskActionsPresenter on Task {
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
      mainController.touchRootTask();
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
    bool unlinked = !hasLink;
    if (!unlinked) {
      unlinked = await unlink(context);
    }
    return unlinked;
  }

  MTDialogAction<bool?> _go2SourceDialogAction(BuildContext context) => MTDialogAction(
        type: MTActionType.isDefault,
        onTap: () => launchUrl(taskSource!.uri),
        result: false,
        child: taskSource!.go2SourceTitle(context),
      );

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
          _go2SourceDialogAction(context),
        ],
      );

  Future<bool?> _unwatchDialog(BuildContext context) async => await showMTDialog<bool?>(
        context,
        title: loc.task_unwatch_dialog_title,
        description: loc.task_unwatch_dialog_description,
        actions: [
          MTDialogAction(
            title: loc.task_unwatch_action_title,
            type: MTActionType.isDanger,
            result: true,
            icon: unwatchIcon(context),
          ),
          _go2SourceDialogAction(context),
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

  /// роутер

  Future setClosed(BuildContext context, bool _closed) async {
    closed = _closed;
    final editedTask = await tasksUC.save(this);
    if (editedTask != null) {
      if (editedTask.closed) {
        Navigator.of(context).pop(editedTask);
      }
      _updateParents(editedTask);
    }
  }

  Future addSubtask(BuildContext context) async {
    if (await _checkUnlinked(context)) {
      final newTask = await editTaskDialog(context, parent: this);
      if (newTask != null) {
        tasks.add(newTask);
        _updateParents(newTask);
      }
    }
  }

  Future edit(BuildContext context) async {
    if (await _checkUnlinked(context)) {
      final editedTask = await editTaskDialog(context, parent: parent!, task: this);
      if (editedTask != null) {
        if (editedTask.deleted) {
          Navigator.of(context).pop();
        }
        _updateParents(editedTask);
      }
    }
  }

  Future<bool> unlink(BuildContext context) async {
    bool res = false;
    if (await _unlinkDialog(context) == true) {
      // startLoading();
      res = await importUC.updateTaskSources(_unlinkTaskTree(this));
      // stopLoading();
    }
    return res;
  }

  Future unwatch(BuildContext context) async {
    if (await _unwatchDialog(context) == true) {
      final deletedTask = await tasksUC.delete(t: this);
      if (deletedTask != null && deletedTask.deleted) {
        Navigator.of(context).pop();
        _updateParents(deletedTask);
      }
    }
  }

  //TODO: startLoading / stopLoading

  Future<void> taskAction(TaskActionType? actionType, BuildContext context) async {
    switch (actionType) {
      case TaskActionType.add:
        await addSubtask(context);
        break;
      case TaskActionType.edit:
        await edit(context);
        break;
      case TaskActionType.import:
        await importController.importTasks(context);
        break;
      case TaskActionType.go2source:
        await launchUrl(taskSource!.uri);
        break;
      case TaskActionType.unlink:
        await unlink(context);
        break;
      case TaskActionType.unwatch:
        await unwatch(context);
        break;
      case null:
    }
  }
}
