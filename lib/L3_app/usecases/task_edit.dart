// Copyright (c) 2023. Alexandr Moroz

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../L1_domain/entities/errors.dart';
import '../../L1_domain/entities/task.dart';
import '../../L2_data/services/api.dart';
import '../../main.dart';
import '../extra/services.dart';

extension TaskEditUC on Task {
  Future<Task?> edit(Future<Task?> function()) async {
    loading = true;
    mainController.refresh();
    Task? et;
    try {
      et = await function();
    } on DioException catch (e) {
      error = MTError(loader.titleText ?? '', description: loader.descriptionText, detail: e.detail);
    }
    loading = false;
    mainController.refresh();

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
    if (isNew) {
      mainController.addTasks([et]);
    } else {
      mainController.setTask(et);
    }
    return et;
  }

  Future<Task?> save() async => await edit(() async {
        final changes = await taskUC.save(this);
        final et = changes?.updated;
        if (et != null) {
          for (Task at in changes?.affected ?? []) {
            mainController.task(at.ws.id!, at.id)?._update(at);
          }
          return _update(et);
        }
        return null;
      });

  Future delete() async => await edit(() async {
        Navigator.of(rootKey.currentContext!).pop();
        final changes = await taskUC.delete(this);
        if (changes?.updated != null) {
          mainController.removeTask(this);
          for (Task at in changes?.affected ?? []) {
            mainController.task(at.ws.id!, at.id)?._update(at);
          }
        }
        return null;
      });
}
