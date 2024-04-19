// Copyright (c) 2024. Alexandr Moroz

import 'package:dio/dio.dart';

import '../../L1_domain/entities/errors.dart';
import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/task_tree.dart';
import '../../L2_data/services/api.dart';
import '../extra/services.dart';
import '../usecases/task_feature_sets.dart';
import '../usecases/task_tree.dart';
import '../usecases/ws_tariff.dart';

// TODO: убрать обращение к tasksMainController. Вынести эту логику в контроллер какой-то, например в TaskController

extension TaskUC on Task {
  Future<Task?> editWrapper(Future<Task?> Function() function) async {
    loading = true;
    tasksMainController.refreshTasksUI();
    Task? et;
    try {
      et = await function();
    } on DioException catch (e) {
      // TODO: ошибка загрузки 404 - нужно показывать диалог?

      error = MTError(loader.titleText ?? '', description: loader.descriptionText, detail: e.detail);
    }
    loading = false;
    tasksMainController.refreshTasksUI(sort: true);

    return et;
  }

  // TODO: постараться избавиться от этой логики
  // TODO: Нужна на случай попадания в аффектед таскс родителей (в т.ч. проекта) при редактировании после расчёта статистики
  // TODO: можно будет поправить вместе с задачей про рефакторинг StatsController (см. в техдолге задачу)
  // TODO: Также используется при обновлении инфы о родителях при загрузке taskNode. Хотя можно просто игнорировать в том случае.
  Task refill(Task et) {
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
    return et;
  }

  // TODO: дернуть обновление интерфейса надо один раз в конце всей операции
  Future<Task?> load() async {
    filled = false;
    return await editWrapper(() async {
      final taskNode = await taskUC.taskNode(wsId, id!);
      if (taskNode != null) {
        // удаление дерева подзадач
        subtasks.toList().forEach((t) => tasksMainController.removeTask(t));

        // новое дерево родителей и подзадач
        // сама задача / цель / проект
        final root = taskNode.root;
        root.filled = true;
        final newTasks = [root, ...taskNode.subtasks];
        // мои задачи из проекта, если обновляем проект с целями
        if (root.isProject && root.hfsGoals) {
          // TODO: может дублироваться загрузка целей здесь и из taskNode выше
          newTasks.addAll(await wsUC.getMyTasks(root.wsId, projectId: root.id!));
        }
        tasksMainController.setTasks(taskNode.parents, refill: true);
        tasksMainController.setTasks(newTasks);
        return root;
      }
      return null;
    });
  }

  Future<Task?> save() async => await editWrapper(() async {
        if (await ws.checkBalance(loc.edit_action_title)) {
          final changes = await taskUC.save(this);
          if (changes != null) {
            // TODO: тут именно такая логика, что нужно в других местах на выходе задача заполненная
            final et = changes.updated.refill(changes.updated);
            tasksMainController.setTasks(changes.affected, refill: true);
            tasksMainController.setTasks([et]);
            return et;
          }
        }
        return null;
      });

  Future<Task?> move(Task destination) async => await editWrapper(() async {
        if (await destination.ws.checkBalance(loc.task_transfer_export_action_title)) {
          final changes = await taskUC.move(this, destination);
          if (changes != null) {
            final newTask = changes.updated;
            tasksMainController.setTasks([newTask]);
            tasksMainController.setTasks(changes.affected, refill: true);
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
            tasksMainController.setTasks(changes.affected, refill: true);
            tasksMainController.setTasks([newTask]);
            return newTask;
          }
        }
        return null;
      });

  Future<Task?> delete() async => await editWrapper(() async {
        final changes = await taskUC.delete(this);
        if (changes != null) {
          tasksMainController.setTasks(changes.affected, refill: true);
          tasksMainController.removeTask(this);
          return this;
        }
        return null;
      });
}
