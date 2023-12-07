// Copyright (c) 2023. Alexandr Moroz

import 'package:dio/dio.dart';

import '../../L1_domain/entities/errors.dart';
import '../../L1_domain/entities/task.dart';
import '../../L2_data/services/api.dart';
import '../extra/services.dart';

extension TaskEditUC on Task {
  Future<Task?> edit(Future<Task?> function()) async {
    loading = true;
    tasksMainController.refreshTasks();
    Task? et;
    try {
      et = await function();
    } on DioException catch (e) {
      error = MTError(loader.titleText ?? '', description: loader.descriptionText, detail: e.detail);
    }
    loading = false;
    tasksMainController.refreshTasks();

    return et;
  }

  Task _update(Task et) {
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

  Future<Task?> save() async => await edit(() async {
        final changes = await taskUC.save(this);
        final et = changes?.updated;
        if (et != null) {
          changes?.affected.forEach((at) => tasksMainController.task(at.wsId, at.id)?._update(at));
          return _update(et);
        }
        return null;
      });

  Future<Task?> duplicate() async => await edit(() async {
        final changes = await taskUC.duplicate(this);
        final newTask = changes?.updated;
        if (newTask != null) {
          for (Task at in changes?.affected ?? []) {
            final existingTask = tasksMainController.task(at.wsId, at.id);
            if (existingTask != null) {
              existingTask._update(at);
            } else {
              tasksMainController.setTask(at);
            }
          }
          tasksMainController.setTask(newTask);
          return newTask;
        }
        return null;
      });

  Future delete() async => await edit(() async {
        final changes = await taskUC.delete(this);
        if (changes?.updated != null) {
          tasksMainController.removeTask(this);
          for (Task at in changes?.affected ?? []) {
            tasksMainController.task(at.wsId, at.id)?._update(at);
          }
        }
        return null;
      });
}
