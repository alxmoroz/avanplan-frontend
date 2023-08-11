// Copyright (c) 2023. Alexandr Moroz

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/system/errors.dart';
import '../../L2_data/services/api.dart';
import '../../main.dart';
import '../extra/services.dart';

extension TaskSaving on Task {
  Future<Task?> _edit(Future<Task?> function()) async {
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

  Future<Task?> save() async => await _edit(() async {
        final et = await taskUC.save(ws, this);
        if (et != null) {
          // вложенности
          if (et.tasks.isEmpty) {
            et.tasks = tasks;
          }
          if (et.members.isEmpty) {
            et.members = members;
          }
          if (et.projectStatuses.isEmpty) {
            et.projectStatuses = projectStatuses;
          }
          if (et.notes.isEmpty) {
            et.notes = notes;
          }

          // структура
          if (parent != null) {
            if (isNew) {
              parent!.tasks.add(et);
            } else {
              final index = parent!.tasks.indexWhere((t) => et.ws.id == t.ws.id && et.id == t.id);
              if (index > -1) {
                parent!.tasks[index] = et;
              }
            }
          }
          if (isNew) {
            mainController.allTasks.add(et);
          } else {
            mainController.setTask(et);
          }
        }
        return et;
      });

  Future delete() async => await _edit(() async {
        Navigator.of(rootKey.currentContext!).pop();
        if (await taskUC.delete(ws, this)) {
          if (parent != null) {
            parent!.tasks.remove(this);
          }
          mainController.allTasks.remove(this);
        }
        return null;
      });
}
