// Copyright (c) 2024. Alexandr Moroz

import 'package:dio/dio.dart';

import '../../L1_domain/entities/errors.dart';
import '../../L1_domain/entities/task.dart';
import '../../L2_data/services/api.dart';
import '../extra/services.dart';
import '../usecases/task_tree.dart';
import '../usecases/ws_tariff.dart';

extension TaskUC on Task {
  Future<Task?> editWrapper(Future<Task?> Function() function) async {
    loading = true;
    tasksMainController.refreshTasks();
    Task? et;
    try {
      et = await function();
    } on DioException catch (e) {
      // TODO: ошибка загрузки 404 - нужно показывать диалог?

      error = MTError(loader.titleText ?? '', description: loader.descriptionText, detail: e.detail);
    }
    loading = false;
    tasksMainController.refreshTasks();

    return et;
  }

  Task update(Task et) {
    // вложенности
    if (et.members.isEmpty) {
      et.members = members;
    }
    if (et.projectStatuses.isEmpty) {
      et.projectStatuses = projectStatuses;
    }
    if (et.projectFeatureSets.isEmpty) {
      et.projectFeatureSets = projectFeatureSets;
    }
    if (et.notes.isEmpty) {
      et.notes = notes;
    }
    if (et.attachments.isEmpty) {
      et.attachments = attachments;
    }

    et.taskSource ??= taskSource;

    if (isNew) {
      tasksMainController.addTasks([et]);
    } else {
      tasksMainController.setTask(et);
    }
    return et;
  }

  Future load() async => await editWrapper(() async {
        final taskNode = await taskUC.getOne(wsId, id!);
        if (taskNode != null) {
          // удаление дерева подзадач
          subtasks.toList().forEach((t) => tasksMainController.removeTask(t));
          // новое дерево подзадач
          for (Task t in taskNode.subtasks) {
            tasksMainController.setTask(t);
          }
          // сама задача
          final root = taskNode.root;
          root.filled = true;
          tasksMainController.setTask(root);
        }
        return null;
      });

  Future<Task?> save() async => await editWrapper(() async {
        if (await ws.checkBalance(loc.edit_action_title)) {
          final changes = await taskUC.save(this);
          final et = changes?.updated;
          if (et != null) {
            changes?.affected.forEach((at) => tasksMainController.task(at.wsId, at.id)?.update(at));
            return update(et);
          }
        }
        return null;
      });

  Future<Task?> move(Task destination) async => await editWrapper(() async {
        if (await destination.ws.checkBalance(loc.task_transfer_export_action_title)) {
          final changes = await taskUC.move(this, destination);
          if (changes != null) {
            final newTask = changes.updated;
            tasksMainController.setTask(newTask);
            tasksMainController.updateTasks(changes.affected);
            tasksMainController.removeTask(this);
            return newTask;
          }
        }
        return null;
      });

  Future<Task?> duplicate() async => await editWrapper(() async {
        if (await ws.checkBalance(loc.task_duplicate_action_title)) {
          final changes = await taskUC.duplicate(this);
          if (changes != null) {
            final newTask = changes.updated;
            tasksMainController.updateTasks(changes.affected);
            tasksMainController.setTask(newTask);
            return newTask;
          }
        }
        return null;
      });

  Future delete() async => await editWrapper(() async {
        final changes = await taskUC.delete(this);
        if (changes != null) {
          tasksMainController.removeTask(this);
          for (Task at in changes.affected) {
            tasksMainController.task(at.wsId, at.id)?.update(at);
          }
        }
        return null;
      });
}
